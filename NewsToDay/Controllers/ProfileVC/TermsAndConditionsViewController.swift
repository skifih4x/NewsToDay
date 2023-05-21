//
//  TermsAndConditionsViewController.swift
//  NewsToDay
//
//  Created by Ilyas Tyumenev on 09.05.2023.
//

import UIKit
import SnapKit

class TermsAndConditionsViewController: UIViewController {
    
    // MARK: - Private Properties
    private let termsAndConditionsView = NewsToDay.TermsAndConditionsView()
    private let localizationManager = LocalizationManager.localizationManager
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        termsAndConditionsView.delegate = self
        addViews()
        addConstraints()
        updateLocalizedStrings()
    }
    
    // MARK: - Private Methods
    private func addViews() {
        view.backgroundColor = .white
        view.addSubview(termsAndConditionsView)
    }
    
    private func addConstraints() {
        termsAndConditionsView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func updateLocalizedStrings() {
        localizationManager.localizeView("TERMS_AND_CONDITIONS_HEADER_LABEL", view: termsAndConditionsView.headerLabel, updatingBlock: nil)
        localizationManager.localizeView("TERMS_AND_CONDITIONS_MAIN_TEXT", view: termsAndConditionsView.mainText, updatingBlock: nil)
    }
}

// MARK: - ProfileViewDelegate
extension TermsAndConditionsViewController: TermsAndConditionsViewDelegate {
    
    func TermsAndConditionsView(_ view: TermsAndConditionsView, backButtonPressed button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
