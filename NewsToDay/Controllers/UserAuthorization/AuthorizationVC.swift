//
//  ViewController.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

class AuthorizationViewController: CustomViewController<AuthorizationView> {
    
    private let localizationManager = LocalizationManager.localizationManager
    
    var signUp: Bool = true {
        willSet {
            if newValue {
                customView.topLabel.text = localizationManager.localizeString("AUTHORIZATION_VC_TRUE_TOP_LABEL")
                customView.greetingLabel.text = localizationManager.localizeString("AUTHORIZATION_VC_TRUE_GREETING_LABEL")
                customView.userNameTextField.isHidden = false
                customView.confirmPasswordTextField.isHidden = false
                customView.forgotPasswordButton.isHidden = true
                customView.signInButton.setTitle(localizationManager.localizeString("AUTHORIZATION_VC_TRUE_SIGNIN_BUTTON"), for: .normal)
                customView.createAccountLabel.text = localizationManager.localizeString("AUTHORIZATION_VC_TRUE_CREATE_ACCOUNT_LABEL")
                customView.createAccountButton.setTitle(localizationManager.localizeString("AUTHORIZATION_VC_TRUE_CREATE_ACCOUNT_BUTTON"), for: .normal)
            } else {
                customView.topLabel.text = localizationManager.localizeString("AUTHORIZATION_VC_FALSE_TOP_LABEL")
                customView.greetingLabel.text = localizationManager.localizeString("AUTHORIZATION_VC_FALSE_GREETING_LABEL")
                customView.userNameTextField.isHidden = true
                customView.confirmPasswordTextField.isHidden = true
                customView.forgotPasswordButton.isHidden = false
                customView.signInButton.setTitle(localizationManager.localizeString("AUTHORIZATION_VC_FALSE_SIGNIN_BUTTON"), for: .normal)
                customView.createAccountLabel.text = localizationManager.localizeString("AUTHORIZATION_VC_FALSE_CREATE_ACCOUNT_LABEL")
                customView.createAccountButton.setTitle(localizationManager.localizeString("AUTHORIZATION_VC_FALSE_CREATE_ACCOUNT_BUTTON"), for: .normal)
            }
        }
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        customView.userNameTextField.delegate = self
        customView.emailTextField.delegate = self
        customView.passwordTextField.delegate = self
        customView.confirmPasswordTextField.delegate = self
    }
    
    func showAlert(title: String, message: String?) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: localizationManager.localizeString("ALERT_OK"), style: .cancel))
        present(alertController, animated: true)
    }
}

//MARK: - AuthorizationViewDelegate
extension AuthorizationViewController: AuthorizationViewDelegate {
    func AuthorizationView(_ view: AuthorizationView, didTapSignInButton button: UIButton) {
        guard let username = customView.usernameText else { return }
        guard let email = customView.emailText else { return }
        guard let password = customView.passwordText else { return }
        guard let confirmPassword = customView.cofirmPasswordText else { return }
        
        if signUp {
            if !username.isEmpty && !email.isEmpty && !password.isEmpty {
                if password == confirmPassword {
                    FirebaseManager.shared.createAccount(email: email, password: password, username: username) { err in
                        if err == nil {
                            let categoriesVC = CategoriesViewController(isFirstEnter: true)
                            categoriesVC.modalPresentationStyle = .fullScreen
                            self.present(categoriesVC, animated: true)
                        } else {
                            guard let error = err else {return}
                            let errString = String(error.localizedDescription)
                            self.showAlert(title: self.localizationManager.localizeString("ALERT_ERROR"), message: errString)
                        }
                    }
                } else {
                    showAlert(title: localizationManager.localizeString("ALERT_DONT_MATCH"), message: nil)
                }
            } else {
                showAlert(title: localizationManager.localizeString("ALERT_FILL"), message: nil)
            }
        } else {
            if !email.isEmpty && !password.isEmpty {
                FirebaseManager.shared.signIn(email: email, password: password) { error in
                    if error == nil {
                        let tabBarController = TabBarController()
                        tabBarController.modalPresentationStyle = .fullScreen
                        self.present(tabBarController, animated: true)
                    } else {
                        guard let error = error else {return}
                        let errString = String(error.localizedDescription)
                        self.showAlert(title: self.localizationManager.localizeString("ALERT_ERROR"), message: errString)
                    }
                }
            } else {
                showAlert(title: localizationManager.localizeString("ALERT_FILL"), message: nil)
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

//MARK: - UITextFieldDelegate
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
