//
//  RegistrationView.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

protocol ForgetPasswordViewDelegate: AnyObject {
    func ForgetPasswordView(_ view: ForgetPasswordView, didTapResetPasswordButton button: UIButton)
    func ForgetPasswordView(_ view: ForgetPasswordView, didTapGoBackButton button: UIButton)
}

class ForgetPasswordView: CustomView {
    weak var delegate: ForgetPasswordViewDelegate?
    private let localizationManager = LocalizationManager.localizationManager
    
    //MARK: - Variables
    
    lazy var goBackButton: UIButton = {
        let element = UIButton()
        element.setTitleColor(Resources.Colors.purplePrimary, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapGoBackButton(_:)), for: .touchUpInside)
        return element
    }()
    
    lazy var topLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        element.textColor = Resources.Colors.blackPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var greetingLabel: UILabel = {
        let element = UILabel()
        element.lineBreakMode = .byWordWrapping
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.textColor = Resources.Colors.greyPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var emailTextField: UITextField = {
        let element = UITextField()
        element.layer.cornerRadius = 12
        element.backgroundColor = Resources.Colors.greyLighter
        
        let imageView = UIImageView(image: Resources.Icons.mail)
        imageView.tintColor = Resources.Colors.greyPrimary
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        element.leftView = containerView
        element.leftViewMode = .always

        element.placeholder = localizationManager.localizeString("FORGET_EMAIL_TEXTFIELD")
        element.keyboardType = .emailAddress
        element.autocorrectionType = .no
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    lazy var resetPasswordButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = Resources.Colors.purplePrimary
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.layer.cornerRadius = 12
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapResetPasswordButton(_:)), for: .touchUpInside)
        return element
    }()

    var emailText: String? {
        return emailTextField.text
    }
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        self.addSubview(goBackButton)
        self.addSubview(topLabel)
        self.addSubview(greetingLabel)
        self.addSubview(emailTextField)
        self.addSubview(resetPasswordButton)
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            goBackButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            topLabel.topAnchor.constraint(equalTo: goBackButton.bottomAnchor, constant: 5),
            topLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            greetingLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 12),
            greetingLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            greetingLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
       
            emailTextField.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 16),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      
            resetPasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 64),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 56),
            resetPasswordButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            resetPasswordButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

//MARK: - Target Actions
private extension ForgetPasswordView {
    @objc func didTapResetPasswordButton(_ button: UIButton) {
        delegate?.ForgetPasswordView(self, didTapResetPasswordButton: button)
    }
    
    @objc func didTapGoBackButton(_ button: UIButton) {
        delegate?.ForgetPasswordView(self, didTapGoBackButton: button)
    }
}

