//
//  TermsAndConditionsView.swift
//  NewsToDay
//
//  Created by Ilyas Tyumenev on 09.05.2023.
//

import UIKit
import SnapKit

protocol TermsAndConditionsViewDelegate: AnyObject {
    func TermsAndConditionsView(_ view: TermsAndConditionsView, backButtonPressed button: UIButton)
}

class TermsAndConditionsView: UIView {
    
    weak var delegate: TermsAndConditionsViewDelegate?
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Resources.Profile.backButton, for: .normal)
        button.tintColor = Resources.Colors.greyPrimary
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = Resources.Colors.blackPrimary
        label.textAlignment = .center
        return label
    }()
    
    let mainText: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 16)
        text.textColor = Resources.Colors.greyPrimary
        text.isScrollEnabled = true
        return text
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
        addSubview(mainText)
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
            make.width.equalTo(227)
        }
        
        mainText.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(19)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }    
}

// MARK: - Target Actions
private extension TermsAndConditionsView {
    
    @objc func backButtonPressed(_ button: UIButton) {
        delegate?.TermsAndConditionsView(self, backButtonPressed: button)
    }
}
