//
//  RegistrationViewController.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

class ForgetPasswordViewController: CustomViewController<ForgetPasswordView> {
    
    var fbManager = FirebaseManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        customView.emailTextField.delegate = self
    }
    
    func showAlert(title: String, message: String?) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertController, animated: true)
    }
}

extension ForgetPasswordViewController: ForgetPasswordViewDelegate {
    func ForgetPasswordView(_ view: ForgetPasswordView, didTapResetPasswordButton button: UIButton) {
        let email = customView.emailText
        
        if !email!.isEmpty {
            fbManager.resetPassword(email: email!)
        } else {
            showAlert(title: "Please fill out all fields", message: nil)
        }
    }
    
    func ForgetPasswordView(_ view: ForgetPasswordView, didTapGoBackButton button: UIButton) {
        self.dismiss(animated: true)
    }
}

extension ForgetPasswordViewController: UITextFieldDelegate {
    
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
