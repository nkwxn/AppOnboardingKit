//
//  OnboardingViewController.swift
//  
//
//  Created by Nicholas on 31/05/22.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    var nextBtnDidTap: ((Int) -> Void)?
    var getStartedBtnDidTap: (() -> Void)?
    
    private let slides: [Slide]
    private let tintColor: UIColor?
    private let themeFont: UIFont
    
    private lazy var transitionView: TransitionView = {
        let view = TransitionView(slides: slides, viewTintColor: tintColor, themeFont: themeFont)
        return view
    }()
    
    private lazy var buttonContainerView: ButtonContainerView = {
        let view = ButtonContainerView(tintColor: tintColor)
        view.nextButtonDidTap = { [weak self] in
            guard let self = self else { return }
            self.nextBtnDidTap?(self.transitionView.slideIndex)
            self.transitionView.handleTap(direction: .right)
        }
        view.getStartedButtonDidTap = getStartedBtnDidTap
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [transitionView, buttonContainerView])
        view.axis = .vertical
        return view
    }()
    
    init(slides: [Slide], tintColor: UIColor?, themeFont: UIFont) {
        self.slides = slides
        self.tintColor = tintColor
        self.themeFont = themeFont
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transitionView.start()
    }
    
    func stopAnimation() {
        transitionView.stop()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        buttonContainerView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(_:)))
        transitionView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func viewDidTap(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: view)
        let midPoint = view.frame.size.width / 2
        if point.x > midPoint {
            transitionView.handleTap(direction: .right)
        } else {
            transitionView.handleTap(direction: .left)
        }
    }
}
