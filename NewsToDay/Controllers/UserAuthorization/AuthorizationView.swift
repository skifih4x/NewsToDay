//
//  AuthorizationView.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

protocol AuthorizationViewDelegate: AnyObject {
    func AuthorizationView(_ view: AuthorizationView, didTapSignInButton button: UIButton)
    func AuthorizationView(_ view: AuthorizationView, didTapCreateAccountButton button: UIButton)
}

class AuthorizationView: CustomView {
    weak var delegate: AuthorizationViewDelegate?
    
    //MARK: - Variables
    private lazy var topLabel: UILabel = {
        let element = UILabel()
        element.text = "Welcome Back 👋"
        element.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        element.textColor = Resources.Colors.blackPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var greetingLabel: UILabel = {
        let element = UILabel()
        element.text = "I am happy to see you again. You can continue where you left off by logging in"
        element.lineBreakMode = .byWordWrapping
        element.numberOfLines = 2
        element.font = UIFont.systemFont(ofSize: 18, weight: .regular)
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
        
        element.placeholder = "Password"
        element.isSecureTextEntry = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var signInButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = Resources.Colors.purplePrimary
        element.setTitle("Sign In", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
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
    
    private lazy var createAccountLabel: UILabel = {
        let element = UILabel()
        element.text = "Don't have an account?"
        element.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        element.textColor = Resources.Colors.blackLighter
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var createAccountButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = nil
        element.setTitle("Sign Up", for: .normal)
        element.setTitleColor(Resources.Colors.blackPrimary, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapCreateAccountButton(_:)), for: .touchUpInside)
        return element
    }()
    
    
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        self.addSubview(topLabel)
        self.addSubview(greetingLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(signInButton)
        self.addSubview(createAccountHStack)
        
        createAccountHStack.addArrangedSubview(createAccountLabel)
        createAccountHStack.addArrangedSubview(createAccountButton)
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
            
            emailTextField.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 40),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 64),
            signInButton.heightAnchor.constraint(equalToConstant: 56),
            signInButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            createAccountHStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            createAccountHStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

//MARK: - Target Actions
private extension AuthorizationView {
    @objc func didTapSignInButton(_ button: UIButton) {
        delegate?.AuthorizationView(self, didTapSignInButton: button)
    }
    
    @objc func didTapCreateAccountButton(_ button: UIButton) {
        delegate?.AuthorizationView(self, didTapCreateAccountButton: button)
    }
    
}
