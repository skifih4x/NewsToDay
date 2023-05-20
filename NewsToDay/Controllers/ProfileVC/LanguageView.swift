//
//  LanguageView.swift
//  NewsToDay
//
//  Created by Ilyas Tyumenev on 09.05.2023.
//

import UIKit
import SnapKit

protocol LanguageViewDelegate: AnyObject {
    func LanguageView(_ view: LanguageView, backButtonPressed button: UIButton)
    func LanguageView(_ view: LanguageView, englishButtonPressed button: UIButton)
    func LanguageView(_ view: LanguageView, russianButtonPressed button: UIButton)
}

class LanguageView: UIView {
    
    weak var delegate: LanguageViewDelegate?
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Resources.Profile.backButton, for: .normal)
        button.tintColor = Resources.Colors.greyPrimary
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("LANGUAGE_HEADER_LABEL", comment: "Language")
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = Resources.Colors.blackPrimary
        label.textAlignment = .center
        return label
    }()
    
    let englishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("LANGUAGE_ENGLISH_BUTTON", comment: "English"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = Resources.Colors.greyDark
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets.left = 24
        button.backgroundColor = Resources.Colors.greyLighter
        button.addTarget(self, action: #selector(englishButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    let russianButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("LANGUAGE_RUSSIAN_BUTTON", comment: "Русский"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = Resources.Colors.greyDark
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets.left = 24
        button.backgroundColor = Resources.Colors.greyLighter
        button.addTarget(self, action: #selector(russianButtonPressed), for: .touchUpInside)
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
        addSubview(backButton)
        addSubview(headerLabel)
        addSubview(englishButton)
        addSubview(russianButton)
    }
    
    private func addConstraints() {
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(headerLabel.snp.centerY)
            make.leading.equalToSuperview().inset(26)
            make.height.width.equalTo(12)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(115)
        }
        
        englishButton.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(56)
        }
        
        russianButton.snp.makeConstraints { make in
            make.top.equalTo(englishButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(19)
            make.height.equalTo(56)
        }
    }    
}

// MARK: - Target Actions
private extension LanguageView {
    
    @objc func backButtonPressed(_ button: UIButton) {
        delegate?.LanguageView(self, backButtonPressed: button)
    }
    
    @objc func englishButtonPressed(_ button: UIButton) {
        delegate?.LanguageView(self, englishButtonPressed: button)
    }
    
    @objc func russianButtonPressed(_ button: UIButton) {
        delegate?.LanguageView(self, russianButtonPressed: button)
    }
}
