//
//  ButtonContainerView.swift
//  
//
//  Created by Nicholas on 31/05/22.
//

import UIKit
import SnapKit

class ButtonContainerView: UIView {
    var nextButtonDidTap: (() -> Void)?
    var getStartedButtonDidTap: (() -> Void)?
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.borderColor = viewTintColor?.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(viewTintColor, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = viewTintColor
        button.layer.shadowColor = viewTintColor?.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 12
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.layer.shadowRadius = 8
        button.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nextButton, getStartedButton])
        stackView.axis = .horizontal
        stackView.spacing = 24
        return stackView
    }()
    
    private let viewTintColor: UIColor?

    init(tintColor: UIColor?) {
        self.viewTintColor = tintColor
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 24, left: 24, bottom: 36, right: 24))
            make.leading.equalTo(snp.leading).offset(24)
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(getStartedButton.snp.width).multipliedBy(0.5)
        }
    }
    
    @objc private func nextButtonTapped() {
        self.nextButtonDidTap?()
    }
    
    @objc private func getStartedButtonTapped() {
        self.getStartedButtonDidTap?()
    }
}
