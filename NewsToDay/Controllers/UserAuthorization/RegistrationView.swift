//
//  RegistrationView.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func RegistrationView(_ view: RegistrationView, didTapSignUpButton button: UIButton)
    func RegistrationView(_ view: RegistrationView, didTapOpenSignInButton button: UIButton)
}

class RegistrationView: CustomView {
    weak var delegate: RegistrationViewDelegate?
    
    //MARK: - Variables
    private lazy var topLabel: UILabel = {
        let element = UILabel()
        element.text = "Welcome to NewsToDay"
        element.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        element.textColor = Resources.Colors.blackPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var greetingLabel: UILabel = {
        let element = UILabel()
        element.text = "Hello, I guess you are new around here. You can start using the application after sign up."
        element.lineBreakMode = .byWordWrapping
        element.numberOfLines = 2
        element.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        element.textColor = Resources.Colors.greyPrimary
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

        element.placeholder = "Username"
        element.keyboardType = .default
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

        element.placeholder = "Email Address"
        element.keyboardType = .emailAddress
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
        
        element.placeholder = "Password"
        element.isSecureTextEntry = true
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
        
        element.placeholder = "Repeat Password"
        element.isSecureTextEntry = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var signUpButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = Resources.Colors.purplePrimary
        element.setTitle("Sign Up", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        element.layer.cornerRadius = 12
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapSignUpButton(_:)), for: .touchUpInside)
        return element
    }()
    
    private lazy var haveAccountHStack: UIStackView = {
        let element = UIStackView()
        element.spacing = 8
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var haveAccountLabel: UILabel = {
        let element = UILabel()
        element.text = "Already have an account?"
        element.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        element.textColor = Resources.Colors.blackLighter
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var haveAccountButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = nil
        element.setTitle("Sign In", for: .normal)
        element.setTitleColor(Resources.Colors.blackPrimary, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapOpenSignInButton(_:)), for: .touchUpInside)
        return element
    }()
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        self.addSubview(topLabel)
        self.addSubview(greetingLabel)
        self.addSubview(userNameTextField)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(confirmPasswordTextField)
        self.addSubview(signUpButton)
        self.addSubview(haveAccountHStack)
        
        haveAccountHStack.addArrangedSubview(haveAccountLabel)
        haveAccountHStack.addArrangedSubview(haveAccountButton)
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            topLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            greetingLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 12),
            greetingLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            greetingLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            userNameTextField.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 40),
            userNameTextField.heightAnchor.constraint(equalToConstant: 56),
            userNameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 16),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 64),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            signUpButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            haveAccountHStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            haveAccountHStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

//MARK: - Target Actions
private extension RegistrationView {
    @objc func didTapSignUpButton(_ button: UIButton) {
        delegate?.RegistrationView(self, didTapSignUpButton: button)
    }
    
    @objc func didTapOpenSignInButton(_ button: UIButton) {
        delegate?.RegistrationView(self, didTapOpenSignInButton: button)
    }
    
    @objc func togglePassword(_ button: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func togglePasswordForConfirm(_ button: UIButton) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
    }
}

