//
//  LanguageView.swift
//  NewsToDay
//
//  Created by Ilyas Tyumenev on 09.05.2023.
//

import UIKit
import SnapKit

class LanguageView: UIView {
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "BackButton"), for: .normal)
        button.tintColor = Resources.Colors.greyPrimary
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = Resources.Colors.blackPrimary
        return label
    }()
    
    let englishButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = Resources.Colors.greyLighter
        configuration.attributedTitle = AttributedString("English", attributes: AttributeContainer([NSAttributedString.Key.foregroundColor: Resources.Colors.greyDark]))
        configuration.attributedTitle?.font = UIFont.systemFont(ofSize: 16)
        configuration.titleAlignment = .leading
        configuration.imagePadding = 250
        configuration.imagePlacement = .trailing
        configuration.cornerStyle = .fixed
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { action in
          debugPrint("English")
        }))
        button.layer.cornerRadius = 12
        return button
    }()
    
    let russianButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = Resources.Colors.greyLighter
        configuration.attributedTitle = AttributedString("Russian", attributes: AttributeContainer([NSAttributedString.Key.foregroundColor: Resources.Colors.greyDark]))
        configuration.attributedTitle?.font = UIFont.systemFont(ofSize: 16)
        configuration.titleAlignment = .leading
        configuration.imagePadding = 250
        configuration.imagePlacement = .trailing
        configuration.cornerStyle = .fixed
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { action in
          debugPrint("Russian")
        }))
        button.layer.cornerRadius = 12
        return button
    }()
    
    @objc func backButtonPressed() {
        print("back")
    }
    
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
            make.top.equalTo(safeAreaLayoutGuide).offset(78)
            make.leading.equalToSuperview().inset(26)
            make.height.width.equalTo(12)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(68)
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
