# AppOnboardingKit

AppOnboardingKit provides an onboarding flow that is simple and easy to implement.
![video-preview](https://github.com/nkwxn/AppOnboardingKit/raw/main/video-preview.gif)

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)

## Requirements

- iOS 15.5 or later
- Xcode 13.4 or later
- Swift 5.0 or later


## Installation
There are two ways to use FavOnboardingKit in your project:
- using Swift Package Manager
- manual install (build frameworks or embed Xcode Project)

### Swift Package Manager

To integrate FavOnboardingKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/nkwxn/AppOnboardingKit.git", .upToNextMajor(from: "1.0.0"))
]
```

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

### Manually

If you prefer not to use Swift Package Manager, you can integrate FavOnboardingKit into your project manually.

---

## Usage

### Quick Start

```swift
import UIKit
import AppOnboardingKit
import SnapKit

class ViewController: UIViewController {
    private var onboardingKit: AppOnboardingKit?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Main View Controller"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        
        DispatchQueue.main.async {
            self.onboardingKit = AppOnboardingKit(
                slides: [
                    .init(image: UIImage(named: "imSlide1"), title: "Tawaran yang dipersonalisasi di 40.000 lebih tempat"),
                    .init(image: UIImage(named: "imSlide2"), title: "Perbanyak reward setiap kali membayar"),
                    .init(image: UIImage(named: "imSlide3"), title: "Nikmati sekarang, PayLater Bagong"),
                    .init(image: UIImage(named: "imSlide4"), title: "Dapatkan cashback dengan kartu Anda"),
                    .init(image: UIImage(named: "imSlide5"), title: "Simpan dan dapatkan cashback dengan Deals atau eCards")
                ],
                tintColor: UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0),
                themeFont: UIFont(name: "American Typewriter Bold", size: 28) ?? .systemFont(ofSize: 28, weight: .bold)
            )
            self.onboardingKit?.delegate = self
            self.onboardingKit?.launchOnboarding(root: self)
        }
    }
    
    override func viewWillLayoutSubviews() {
        label.snp.makeConstraints { make in
            make.margins.equalTo(view.snp.margins)
        }
    }
}

extension ViewController: AppOnboardingKitDelegate {
    func nextButtonDidTap(atIndex index: Int) {
        print("Next Button tapped. Current index: \(index)")
    }
    
    func getStartedButtonDidTap() {
        onboardingKit?.dismissOnboarding()
        onboardingKit = nil
        
        transit(viewController: MainViewController())
    }
    
    private func transit(viewController: UIViewController) {
        let foregroundScenes = UIApplication.shared.connectedScenes.filter {
            $0.activationState == .foregroundActive
        }
        
        let window = foregroundScenes
            .map {
                $0 as? UIWindowScene
            }.compactMap { $0 }
            .first?
            .windows
            .filter({
                $0.isKeyWindow
            }).first
        
        guard let window = window else { return }
        window.rootViewController = viewController
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
}

class MainViewController: UIViewController {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Main View Controller"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        view.backgroundColor = .secondarySystemBackground
    }
}
```

## Credits

- Nicholas
