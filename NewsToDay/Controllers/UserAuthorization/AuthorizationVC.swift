//
//  ViewController.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

class AuthorizationViewController: CustomViewController<AuthorizationView> {
    
    var fbManager = FirebaseManager.shared
    
    var signUp: Bool = true {
        willSet {
            if newValue {
                customView.topLabel.text = "Welcome to NewsToDay"
                customView.greetingLabel.text = "Hello, I guess you are new around here. You can start using the application after sign up."
                customView.userNameTextField.isHidden = false
                customView.confirmPasswordTextField.isHidden = false
                customView.forgotPasswordButton.isHidden = true
                customView.signInButton.setTitle("Sign Up", for: .normal)
                customView.createAccountLabel.text = "Already have an account?"
                customView.createAccountButton.setTitle("Sign In", for: .normal)
            } else {
                customView.topLabel.text = "Welcome Back 👋"
                customView.greetingLabel.text = "I am happy to see you again. You can continue where you left off by logging in"
                customView.userNameTextField.isHidden = true
                customView.confirmPasswordTextField.isHidden = true
                customView.forgotPasswordButton.isHidden = false
                customView.signInButton.setTitle("Sign In", for: .normal)
                customView.createAccountLabel.text = "Don't have an account?"
                customView.createAccountButton.setTitle("Sign Up", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        customView.userNameTextField.delegate = self
        customView.emailTextField.delegate = self
        customView.passwordTextField.delegate = self
        customView.confirmPasswordTextField.delegate = self
    }
    
    func showAlert(title: String, message: String?, closeScreen: Bool = false) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        if closeScreen == false {
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        } else {
            alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: { _ in
                self.dismiss(animated: true)
            }))
        }
        present(alertController, animated: true)
    }
}

extension AuthorizationViewController: AuthorizationViewDelegate {
    func AuthorizationView(_ view: AuthorizationView, didTapSignInButton button: UIButton) {
        let username = customView.usernameText
        let email = customView.emailText
        let password = customView.passwordText
        let confirmPassword = customView.cofirmPasswordText
        
        if signUp {
            if !username!.isEmpty && !email!.isEmpty && !password!.isEmpty {
                if password == confirmPassword {
                    fbManager.createAccount(email: email!, password: password!, username: username!)
                    self.dismiss(animated: true)
                } else {
                    showAlert(title: "Passwords don't match, please try again", message: nil)
                }
            } else {
                showAlert(title: "Please fill out all fields", message: nil)
            }
        } else {
            if !email!.isEmpty && !password!.isEmpty {
                fbManager.signIn(email: email!, password: password!)
                self.dismiss(animated: true)
            } else {
                showAlert(title: "Please fill out all fields", message: nil)
            }
        }
    }
    
    func AuthorizationView(_ view: AuthorizationView, didTapForgotPasswordButton button: UIButton) {
        let forgetPasswordVC = ForgetPasswordViewController()
        forgetPasswordVC.modalPresentationStyle = .fullScreen
        self.present(forgetPasswordVC, animated: true)
    }
    
    func AuthorizationView(_ view: AuthorizationView, didTapCreateAccountButton button: UIButton) {
        signUp.toggle()
    }
}

extension AuthorizationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let hasText = !newText.isEmpty
        
        if hasText {
            if let containerView = textField.leftView {
                if let imageView = containerView.subviews.first as? UIImageView {
                    imageView.tintColor = Resources.Colors.purplePrimary
                }
            }
        }
        else {
            if let containerView = textField.leftView {
                if let imageView = containerView.subviews.first as? UIImageView {
                    imageView.tintColor = Resources.Colors.greyPrimary
                }
            }
        }

        return true
    }
}
