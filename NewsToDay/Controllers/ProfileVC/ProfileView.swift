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
    func ProfileView(_ view: ProfileView, termsAndConditionsButtonPressed button: UIButton)
    func ProfileView(_ view: ProfileView, signOutButtonPressed button: UIButton)
}

class ProfileView: UIView {
    
    weak var delegate: ProfileViewDelegate?
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = Resources.Colors.blackPrimary
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ProfileImage")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 36
        image.clipsToBounds = true
        return image
    }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dev P"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Resources.Colors.blackPrimary
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "dev@gmail.com"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Resources.Colors.greyPrimary
        return label
    }()
    
    let languageButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = Resources.Colors.greyLighter
        configuration.attributedTitle = AttributedString("Language", attributes: AttributeContainer([NSAttributedString.Key.foregroundColor: Resources.Colors.greyDark]))
        configuration.attributedTitle?.font = UIFont.systemFont(ofSize: 16)
        configuration.titleAlignment = .leading
        configuration.image = UIImage(named: "LanguageButton")
        configuration.imagePadding = 250
        configuration.imagePlacement = .trailing
        configuration.cornerStyle = .fixed
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.addTarget(self, action: #selector(languageButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    let termsAndConditionsButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = Resources.Colors.greyLighter
        configuration.attributedTitle = AttributedString("Terms & Conditions", attributes: AttributeContainer([NSAttributedString.Key.foregroundColor: Resources.Colors.greyDark]))
        configuration.attributedTitle?.font = UIFont.systemFont(ofSize: 16)
        configuration.titleAlignment = .leading
        configuration.image = UIImage(named: "LanguageButton")
        configuration.imagePadding = 180
        configuration.imagePlacement = .trailing
        configuration.cornerStyle = .fixed
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.addTarget(self, action: #selector(termsAndConditionsButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    let signOutButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = Resources.Colors.greyLighter
        configuration.attributedTitle = AttributedString("Sign Out", attributes: AttributeContainer([NSAttributedString.Key.foregroundColor: Resources.Colors.greyDark]))
        configuration.attributedTitle?.font = UIFont.systemFont(ofSize: 16)
        configuration.titleAlignment = .leading
        configuration.image = UIImage(named: "SignOutButton")
        configuration.imagePadding = 250
        configuration.imagePlacement = .trailing
        configuration.cornerStyle = .fixed
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
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
        addSubview(termsAndConditionsButton)
        addSubview(signOutButton)
    }
    
    private func addConstraints() {
        profileLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(72)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(32)
            make.width.equalTo(75)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(72)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(148)
            make.leading.equalTo(profileImageView.snp.trailing).offset(24)
            make.height.equalTo(24)
            make.width.equalTo(45)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(24)
            make.height.equalTo(24)
            make.width.equalTo(105)
        }
        
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).inset(-148)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(56)
        }
        
        termsAndConditionsButton.snp.makeConstraints { make in
            make.bottom.equalTo(signOutButton.snp.top).inset(-28)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(56)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(28)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(56)
        }
    }
}

// MARK: - Target Actions
private extension ProfileView {
    
    @objc func languageButtonPressed(_ button: UIButton) {
        delegate?.ProfileView(self, languageButtonPressed: button)
    }
    
    @objc func termsAndConditionsButtonPressed(_ button: UIButton) {
        delegate?.ProfileView(self, termsAndConditionsButtonPressed: button)
    }
    
    @objc func signOutButtonPressed(_ button: UIButton) {
        delegate?.ProfileView(self, signOutButtonPressed: button)
    }
}
