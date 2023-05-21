//
//  RegistrationViewController.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

class ForgetPasswordViewController: CustomViewController<ForgetPasswordView> {
    
    private let localizationManager = LocalizationManager.localizationManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        customView.emailTextField.delegate = self
        updateLocalizedStrings()
    }
    
    func showAlert(title: String, message: String?) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertController, animated: true)
    }
    
    private func updateLocalizedStrings() {
        localizationManager.localizeView("FORGET_GO_BACK_BUTTON", view: customView.goBackButton, updatingBlock: nil)
        localizationManager.localizeView("FORGET_TOP_LABEL", view: customView.topLabel, updatingBlock: nil)
        localizationManager.localizeView("FORGET_GREETING_LABEL", view: customView.greetingLabel, updatingBlock: nil)
        localizationManager.localizeView("FORGET_EMAIL_TEXTFIELD", view: customView.emailTextField, updatingBlock: nil)
        localizationManager.localizeView("FORGET_RESET_PASSWORD_BUTTON", view: customView.resetPasswordButton, updatingBlock: nil)
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
                    self?.showAlert(title: (self?.localizationManager.localizeString("ALERT_ERROR"))!, message: errString)
                }
            }
        } else {
            showAlert(title: localizationManager.localizeString("FORGET_RESET_PASSWORD_ALERT"), message: nil)
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
