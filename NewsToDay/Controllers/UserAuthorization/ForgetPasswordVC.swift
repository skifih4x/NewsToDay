//
//  RegistrationViewController.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

class ForgetPasswordViewController: CustomViewController<ForgetPasswordView> {
    
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
        guard let email = customView.emailText else { return }
        
        if !email.isEmpty {
            FirebaseManager.shared.resetPassword(email: email) { [weak self] err in
                if err == nil {
                    self?.dismiss(animated: true)
                } else {
                    guard let error = err else {return}
                    let errString = String(error.localizedDescription)
                    self?.showAlert(title: NSLocalizedString("ALERT_ERROR", comment: "Ooops!"), message: errString)
                }
            }
        } else {
            showAlert(title: NSLocalizedString("FORGET_RESET_PASSWORD_ALERT", comment: "Please fill in the email address"), message: nil)
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
