//
//  RegistrationViewController.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit
import Firebase

class RegistrationViewController: CustomViewController<RegistrationView> {
    
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
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertController, animated: true)
    }
}

extension RegistrationViewController: RegistrationViewDelegate {
    func RegistrationView(_ view: RegistrationView, didTapSignUpButton button: UIButton) {
        let username = customView.usernameText
        let email = customView.emailText
        let password = customView.passwordText
        let confirmPassword = customView.cofirmPasswordText
        
        if !username!.isEmpty && !email!.isEmpty && !password!.isEmpty {
            if password == confirmPassword {
                Auth.auth().createUser(withEmail: email!, password: password!) { result, error in
                    if error == nil {
                        if let result = result {
                            // Действия после регистрации
                            print(result.user.uid)
                        }
                    } else {
                        let errString = String(error!.localizedDescription)
                        self.showAlert(title: "Error", message: errString)
                    }
                }
            } else {
                showAlert(title: "Passwords don't match, please try again", message: nil)
            }
        } else {
            showAlert(title: "Please fill out all fields", message: nil)
        }
    }
    
    func RegistrationView(_ view: RegistrationView, didTapOpenSignInButton button: UIButton) {
        self.dismiss(animated: true)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
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
