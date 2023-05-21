//
//  LanguageViewController.swift
//  NewsToDay
//
//  Created by Ilyas Tyumenev on 09.05.2023.
//

import UIKit
import SnapKit

class LanguageViewController: UIViewController {
    
    // MARK: - Private Properties
    private let languageView = NewsToDay.LanguageView()
    private let localizationManager = LocalizationManager.localizationManager
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        languageView.delegate = self
        addViews()
        addConstraints()
        setLocalizedStrings()
    }
    
    // MARK: - Private Methods
    private func addViews() {
        view.backgroundColor = .white
        view.addSubview(languageView)
    }
    
    private func addConstraints() {
        languageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setLanguage(_ languageCode: String) {
        localizationManager.setLanguage(languageCode: languageCode)        
    }
    
    private func setLocalizedStrings() {
        localizationManager.localizeView("LANGUAGE_HEADER_LABEL", view: languageView.headerLabel, updatingBlock: nil)
        localizationManager.localizeView("LANGUAGE_ENGLISH_BUTTON", view: languageView.englishButton, updatingBlock: nil)
        localizationManager.localizeView("LANGUAGE_RUSSIAN_BUTTON", view: languageView.russianButton, updatingBlock: nil)
    }
}

// MARK: - LanguageViewDelegate
extension LanguageViewController: LanguageViewDelegate {
    
    func languageView(_ view: LanguageView, backButtonPressed button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func languageView(_ view: LanguageView, englishButtonPressed button: UIButton) {
        setLanguage("en")
    }
    
    func languageView(_ view: LanguageView, russianButtonPressed button: UIButton) {
        setLanguage("ru")
    }
}
