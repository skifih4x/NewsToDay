//
//  AuthorizationView.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

protocol AuthorizationViewDelegate: AnyObject {
    func AuthorizationView(_ view: AuthorizationView, didTapSignInButton button: UIButton)
    func AuthorizationView(_ view: AuthorizationView, didTapForgotPasswordButton button: UIButton)
    func AuthorizationView(_ view: AuthorizationView, didTapCreateAccountButton button: UIButton)
}

class AuthorizationView: CustomView {
    weak var delegate: AuthorizationViewDelegate?
    private let localizationManager = LocalizationManager.localizationManager
    
    //MARK: - Variables
    lazy var topLabel: UILabel = {
        let element = UILabel()
        element.text = localizationManager.localizeString("AUTHORIZATION_VC_TRUE_TOP_LABEL")
        element.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        element.adjustsFontSizeToFitWidth = true
        element.minimumScaleFactor = 0.5
        element.textColor = Resources.Colors.blackPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var greetingLabel: UILabel = {
        let element = UILabel()
        element.text = localizationManager.localizeString("AUTHORIZATION_VC_TRUE_GREETING_LABEL")
        element.lineBreakMode = .byWordWrapping
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.textColor = Resources.Colors.greyPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var textFieldsVStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 16
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var userNameTextField: UITextField = {
        let element = UITextField()
        element.layer.cornerRadius = 12
        element.backgroundColor = Resources.Colors.greyLighter
        
        let imageView = UIImageView(image: Resources.Icons.person)
        imageView.tintColor = Resources.Colors.greyPrimary
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        element.leftView = containerView
        element.leftViewMode = .always

        element.placeholder = localizationManager.localizeString("AUTHORIZATION_VIEW_USERNAME_TEXTFIELD")
        element.keyboardType = .default
        element.autocorrectionType = .no
        element.returnKeyType = .done
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

        element.placeholder = localizationManager.localizeString("AUTHORIZATION_VIEW_EMAIL_TEXTFIELD")
        element.keyboardType = .emailAddress
        element.autocorrectionType = .no
        element.returnKeyType = .done
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var passwordTextField: UITextField = {
        let element = UITextField()
        element.layer.cornerRadius = 12
        element.backgroundColor = Resources.Colors.greyLighter
        
        let imageView = UIImageView(image: Resources.Icons.lock)
        imageView.tintColor = Resources.Colors.greyPrimary
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        element.leftView = containerView
        element.leftViewMode = .always
        
        let button = UIButton(type: .custom)
        button.setImage(Resources.Icons.eye, for: .normal)
        button.tintColor = Resources.Colors.greyPrimary
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(togglePassword(_:)), for: .touchUpInside)
        let containerViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        containerViewRight.addSubview(button)
        button.center = containerViewRight.center
        
        element.rightView = containerViewRight
        element.rightViewMode = .always
        
        element.placeholder = localizationManager.localizeString("AUTHORIZATION_VIEW_PASSWORD_TEXTFIELD")
        element.autocorrectionType = .no
        element.isSecureTextEntry = true
        element.returnKeyType = .done
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let element = UITextField()
        element.layer.cornerRadius = 12
        element.backgroundColor = Resources.Colors.greyLighter
        
        let imageView = UIImageView(image: Resources.Icons.lock)
        imageView.tintColor = Resources.Colors.greyPrimary
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        element.leftView = containerView
        element.leftViewMode = .always
        
        let button = UIButton(type: .custom)
        button.setImage(Resources.Icons.eye, for: .normal)
        button.tintColor = Resources.Colors.greyPrimary
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(togglePasswordForConfirm(_:)), for: .touchUpInside)
        let containerViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        containerViewRight.addSubview(button)
        button.center = containerViewRight.center
        
        element.rightView = containerViewRight
        element.rightViewMode = .always
        
        element.placeholder = localizationManager.localizeString("AUTHORIZATION_VIEW_CONFIRM_PASSWORD_TEXTFIELD")
        element.isSecureTextEntry = true
        element.autocorrectionType = .no
        element.returnKeyType = .done
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = nil
        element.setTitle(localizationManager.localizeString("AUTHORIZATION_VIEW_FORGOT_PASSWORD_BUTTON"), for: .normal)
        element.setTitleColor(Resources.Colors.blackPrimary, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapForgotPasswordButton(_:)), for: .touchUpInside)
        element.isHidden = true
        return element
    }()
    
    lazy var signInButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = Resources.Colors.purplePrimary
        element.setTitle(localizationManager.localizeString("AUTHORIZATION_VIEW_SIGNIN_BUTTON"), for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.layer.cornerRadius = 12
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapSignInButton(_:)), for: .touchUpInside)
        return element
    }()
    
    private lazy var createAccountHStack: UIStackView = {
        let element = UIStackView()
        element.spacing = 8
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var createAccountLabel: UILabel = {
        let element = UILabel()
        element.text = localizationManager.localizeString("AUTHORIZATION_VIEW_CREATE_ACCOUNT_LABEL")
        element.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.textColor = Resources.Colors.blackLighter
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var createAccountButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = nil
        element.setTitle(localizationManager.localizeString("AUTHORIZATION_VIEW_CREATE_ACCOUNT_BUTTON"), for: .normal)
        element.setTitleColor(Resources.Colors.blackPrimary, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapCreateAccountButton(_:)), for: .touchUpInside)
        return element
    }()
    
    var usernameText: String? {
        return userNameTextField.text
    }
    
    var emailText: String? {
        return emailTextField.text
    }
    
    var passwordText: String? {
        return passwordTextField.text
    }
    
    var cofirmPasswordText: String? {
        return confirmPasswordTextField.text
    }
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        self.addSubview(topLabel)
        self.addSubview(greetingLabel)
        self.addSubview(textFieldsVStack)
        self.addSubview(forgotPasswordButton)
        self.addSubview(signInButton)
        self.addSubview(createAccountHStack)
        
        textFieldsVStack.addArrangedSubview(userNameTextField)
        textFieldsVStack.addArrangedSubview(emailTextField)
        textFieldsVStack.addArrangedSubview(passwordTextField)
        textFieldsVStack.addArrangedSubview(confirmPasswordTextField)
        
        createAccountHStack.addArrangedSubview(createAccountLabel)
        createAccountHStack.addArrangedSubview(createAccountButton)
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 72),
            topLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            topLabel.heightAnchor.constraint(equalToConstant: 32),
            
            greetingLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            greetingLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            greetingLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            textFieldsVStack.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 32),
            textFieldsVStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textFieldsVStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            userNameTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: textFieldsVStack.bottomAnchor, constant: 16),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
            signInButton.heightAnchor.constraint(equalToConstant: 56),
            signInButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            createAccountHStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42),
            createAccountHStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

//MARK: - Target Actions
private extension AuthorizationView {
    @objc func didTapSignInButton(_ button: UIButton) {
        delegate?.AuthorizationView(self, didTapSignInButton: button)
    }
    
    @objc func didTapForgotPasswordButton(_ button: UIButton) {
        delegate?.AuthorizationView(self, didTapForgotPasswordButton: button)
    }
    
    @objc func didTapCreateAccountButton(_ button: UIButton) {
        delegate?.AuthorizationView(self, didTapCreateAccountButton: button)
    }
    
    @objc func togglePassword(_ button: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func togglePasswordForConfirm(_ button: UIButton) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
    }
}
