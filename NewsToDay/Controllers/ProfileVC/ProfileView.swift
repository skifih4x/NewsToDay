//
//  ProfileView.swift
//  NewsToDay
//
//  Created by Ilyas Tyumenev on 09.05.2023.
//

import UIKit
import SnapKit

protocol ProfileViewDelegate: AnyObject {
    func ProfileView(_ view: ProfileView, languageButtonPressed button: UIButton)
    func ProfileView(_ view: ProfileView, developerTeamButtonPressed button: UIButton)
    func ProfileView(_ view: ProfileView, termsAndConditionsButtonPressed button: UIButton)
    func ProfileView(_ view: ProfileView, signOutButtonPressed button: UIButton)
}

class ProfileView: UIView {
    
    weak var delegate: ProfileViewDelegate?
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("PROFILE_PROFILE_LABEL", comment: "Profile")
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = Resources.Colors.blackPrimary
        return label
    }()
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 36
        image.clipsToBounds = true
        return image
    }()
        
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Resources.Colors.blackPrimary
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Resources.Colors.greyPrimary
        return label
    }()
    
    let languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("PROFILE_LANGUAGE_BUTTON", comment: "Language"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = Resources.Colors.greyDark
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets.left = 24
        button.backgroundColor = Resources.Colors.greyLighter
        button.setBackgroundColorForTap(color: Resources.Colors.purplePrimary, forState: .highlighted)
        button.addTarget(self, action: #selector(languageButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let languageButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = Resources.Profile.languageButton
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var developerTeamButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Команда разработки", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = Resources.Colors.greyDark
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets.left = 24
        button.backgroundColor = Resources.Colors.greyLighter
        button.setBackgroundColorForTap(color: Resources.Colors.purplePrimary, forState: .highlighted)
        button.addTarget(self, action: #selector(developerTeamButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let developerTeamButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = Resources.Profile.languageButton
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var termsAndConditionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("PROFILE_TERMS_AND_CONDITIONS_BUTTON", comment: "Terms & Conditions"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = Resources.Colors.greyDark
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets.left = 24
        button.backgroundColor = Resources.Colors.greyLighter
        button.setBackgroundColorForTap(color: Resources.Colors.purplePrimary, forState: .highlighted)
        button.addTarget(self, action: #selector(termsAndConditionsButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let termsAndConditionsButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = Resources.Profile.languageButton
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("PROFILE_SIGN_OUT_BUTTON", comment: "Sign Out"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = Resources.Colors.greyDark
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets.left = 24
        button.backgroundColor = Resources.Colors.greyLighter
        button.setBackgroundColorForTap(color: Resources.Colors.purplePrimary, forState: .highlighted)
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let signOutButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = Resources.Profile.signOutButton
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addViews() {
        addSubview(profileLabel)
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(emailLabel)
        addSubview(languageButton)
        addSubview(languageButtonImage)
        addSubview(developerTeamButton)
        addSubview(developerTeamButtonImage)
        addSubview(termsAndConditionsButton)
        addSubview(termsAndConditionsButtonImage)
        addSubview(signOutButton)
        addSubview(signOutButtonImage)
    }
    
    private func addConstraints() {
        profileLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(32)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(72)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(44)
            make.leading.equalTo(profileImageView.snp.trailing).offset(24)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(24)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(24)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(24)
        }
        
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).inset(-148)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(56)
        }
        
        languageButtonImage.snp.makeConstraints { make in
            make.centerY.equalTo(languageButton.snp.centerY)
            make.centerX.equalTo(signOutButtonImage.snp.centerX)
            make.height.equalTo(11)
            make.width.equalTo(7)
        }
        
        developerTeamButton.snp.makeConstraints { make in
            make.bottom.equalTo(termsAndConditionsButton.snp.top).inset(-28)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(56)
        }
        
        developerTeamButtonImage.snp.makeConstraints { make in
            make.centerY.equalTo(developerTeamButton.snp.centerY)
            make.centerX.equalTo(signOutButtonImage.snp.centerX)
            make.height.equalTo(11)
            make.width.equalTo(7)
        }
        
        termsAndConditionsButton.snp.makeConstraints { make in
            make.bottom.equalTo(signOutButton.snp.top).inset(-28)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(56)
        }
        
        termsAndConditionsButtonImage.snp.makeConstraints { make in
            make.centerY.equalTo(termsAndConditionsButton.snp.centerY)
            make.centerX.equalTo(signOutButtonImage.snp.centerX)
            make.height.equalTo(11)
            make.width.equalTo(7)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(28)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(56)
        }
        
        signOutButtonImage.snp.makeConstraints { make in
            make.centerY.equalTo(signOutButton.snp.centerY)
            make.trailing.equalTo(signOutButton.snp.trailing).inset(18)
            make.height.equalTo(20)
            make.width.equalTo(16)
        }
    }
}

// MARK: - Target Actions
private extension ProfileView {
    
    @objc func languageButtonPressed(_ button: UIButton) {
        delegate?.ProfileView(self, languageButtonPressed: button)
    }
    
    @objc func developerTeamButtonPressed(_ button: UIButton) {
        delegate?.ProfileView(self, developerTeamButtonPressed: button)
    }
    
    @objc func termsAndConditionsButtonPressed(_ button: UIButton) {
        delegate?.ProfileView(self, termsAndConditionsButtonPressed: button)
    }
    
    @objc func signOutButtonPressed(_ button: UIButton) {
        delegate?.ProfileView(self, signOutButtonPressed: button)
    }
}

// MARK: - UIButton Extension
extension UIButton {
    func setBackgroundColorForTap(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
