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
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        languageView.delegate = self
        addViews()
        addConstraints()
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
    
    func setLanguage(_ language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    func restartApp() {
        if let urlTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? [[String: Any]],
           let urlSchemes = urlTypes.first?["CFBundleURLSchemes"] as? [String],
           let urlScheme = urlSchemes.first {
            print("URL-схема приложения: \(urlScheme)")
        } else {
            print("URL-схема не указана в Info.plist")
        }
        
        let alertController = UIAlertController(title: NSLocalizedString("LANGUAGE_ALERT_TITLE", comment: "Restart the application"),
                                                message: NSLocalizedString("LANGUAGE_ALERT_MESSAGE", comment: "Restart the app to change the language?"),
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("LANGUAGE_ALERT_CANCEL_ACTION", comment: "Cancel"),
                                         style: .cancel,
                                         handler: nil)
        let okAction = UIAlertAction(title: NSLocalizedString("LANGUAGE_ALERT_OK_ACTION", comment: "Yes"),
                                     style: .default) { (_) in
            UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
            
            if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
            }
            if let url = URL(string: "myapp") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    print("Невозможно открыть URL-схему")
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - LanguageViewDelegate
extension LanguageViewController: LanguageViewDelegate {
    
    func LanguageView(_ view: LanguageView, backButtonPressed button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func LanguageView(_ view: LanguageView, englishButtonPressed button: UIButton) {
        setLanguage("en")
        restartApp()
    }
    
    func LanguageView(_ view: LanguageView, russianButtonPressed button: UIButton) {
        setLanguage("ru")
        restartApp()
    }
}
