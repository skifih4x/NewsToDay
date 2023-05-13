//
//  ProfileViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Private Properties
    private let profilelView = NewsToDay.ProfileView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        profilelView.delegate = self
        addViews()
        addConstraints()
    }
    
    // MARK: - Private Methods
    private func addViews() {
        view.backgroundColor = .white
        view.addSubview(profilelView)
    }
    
    private func addConstraints() {
        profilelView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    
    func ProfileView(_ view: ProfileView, languageButtonPressed button: UIButton) {
        let languageVC = LanguageViewController()
        languageVC.modalPresentationStyle = .fullScreen
        languageVC.modalTransitionStyle = .crossDissolve
        self.present(languageVC, animated: true)
    }
    
    func ProfileView(_ view: ProfileView, termsAndConditionsButtonPressed button: UIButton) {
        let termsAndConditionsVC = TermsAndConditionsViewController()
        termsAndConditionsVC.modalPresentationStyle = .fullScreen
        termsAndConditionsVC.modalTransitionStyle = .crossDissolve
        self.present(termsAndConditionsVC, animated: true)
    }
    
    func ProfileView(_ view: ProfileView, signOutButtonPressed button: UIButton) {
        let onboardingVC = OnboardingViewController()
        onboardingVC.modalPresentationStyle = .fullScreen
        onboardingVC.modalTransitionStyle = .crossDissolve
        self.present(onboardingVC, animated: true)
    }
}
