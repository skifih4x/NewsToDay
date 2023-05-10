//
//  ViewController.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit
import Firebase

class AuthorizationViewController: CustomViewController<AuthorizationView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        customView.emailTextField.delegate = self
        customView.passwordTextField.delegate = self
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
        let email = customView.emailText
        let password = customView.passwordText
        
        if !email!.isEmpty && !password!.isEmpty {
            Auth.auth().signIn(withEmail: email!, password: password!)
            { result, error in
                if error == nil {
                    if let result = result {
                        let name = Database.database().reference(withPath: "users")
                        name.child(result.user.uid).child("name").getData { error, data in
                            if error == nil {
                                if let data = data {
                                    let name = data.value as? String ?? "NoName"
                                    self.showAlert(title: "Sign In success!", message: "Hi, \(name)", closeScreen: true)
                                }
                            }
                        }
                    }
                } else {
                    let errString = String(error!.localizedDescription)
                    self.showAlert(title: "Error", message: errString)
                }
            }
        } else {
            showAlert(title: "Please fill out all fields", message: nil)
        }
    }
    
    func AuthorizationView(_ view: AuthorizationView, didTapCreateAccountButton button: UIButton) {
        let registrationVC = RegistrationViewController()
        registrationVC.modalPresentationStyle = .fullScreen
        self.present(registrationVC, animated: true)
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
