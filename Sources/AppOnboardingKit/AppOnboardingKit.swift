import UIKit

public protocol AppOnboardingKitDelegate: AnyObject {
    func nextButtonDidTap(atIndex index: Int)
    func getStartedButtonDidTap()
}

public class AppOnboardingKit {
    private let slides: [Slide]
    private let tintColor: UIColor
    private var rootVC: UIViewController?
    
    public weak var delegate: AppOnboardingKitDelegate?
    
    private lazy var onboardingViewController: OnboardingViewController = {
        let controller = OnboardingViewController(slides: self.slides, tintColor: self.tintColor)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        controller.nextBtnDidTap = { [weak self] index in
            self?.delegate?.nextButtonDidTap(atIndex: index)
        }
        controller.getStartedBtnDidTap = { [weak self] in
            self?.delegate?.getStartedButtonDidTap()
        }
        return controller
    }()
    
    public init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
    }
    
    // UIViewController should be passed in to launch onboarding
    public func launchOnboarding(root: UIViewController) {
        self.rootVC = root
        rootVC?.present(onboardingViewController, animated: true, completion: nil)
    }
    
    public func dismissOnboarding() {
        onboardingViewController.stopAnimation()
        if rootVC?.presentedViewController == onboardingViewController {
            onboardingViewController.dismiss(animated: true)
        }
    }
}
