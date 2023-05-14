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
        button.setImage(UIImage(named: "BackButton"), for: .normal)
        button.tintColor = Resources.Colors.greyPrimary
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("TERMS_AND_CONDITIONS_HEADER_LABEL", comment: "Terms & Conditions")
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = Resources.Colors.blackPrimary
        label.textAlignment = .center
        return label
    }()
    
    private let mainText: UITextView = {
        let text = UITextView()
        let mainText = """
                                      The User Agreement for the application (hereinafter referred to as the Agreement) is a special type of agreement between the owners of the application and its users regarding the procedure for its use, and also defines the obligations of the parties and their responsibilities.
                                      
                                      This document is not required by the current legislation, but it helps users (1) understand the permissible ways they use the application on a smartphone or other device; (2) determine the possible consequences of using the application in one way or another; (3) identify the liability measures applied to users for violating the established rules.
                                      
                                      The agreement is nothing more than the rules of the game for the user, because of this, it is difficult to overestimate the value of this document. As soon as the user agrees to the terms of the Agreement (for example, by ticking a box in the allotted field or by installing the program on a smartphone), the terms of this Agreement are legally binding for the user. Thus, the violation by the user of the terms of the Agreement inevitably entails the application to such a user of the types of liability provided for in such an Agreement.
                                      
                                      The proposed document template is suitable for applications of any kind, for example, an online store, a game, a social network, access to a cloud platform, business, media (magazines), etc. Please note that this document cannot be used for websites (you can use the User Agreement for the website) or cloud platforms (you can use the User Agreement for the cloud platform).
                                      
                                      The User Agreement should not be identified with the Privacy Policy (a document defining the procedure for collecting and processing personal data of users) for several reasons. Firstly, the privacy policy is a mandatory document, and secondly, such a document exclusively focuses on the methods, methods, timing and purposes of processing and collecting personal data.
                                      
                                      
                                      How to use the document
                                      
                                      The User Agreement can be used by individuals and legal entities, as well as individual entrepreneurs who create their own application and place it for download by users on Google Play or the App Store. The document is valid without limitation of its validity.
                                      
                                      The structure of the proposed template allows you to determine (1) whether you need to create your own personal account to use the application; and (2) what actions are prohibited to users; and (3) whether users have the right to post their own copyrighted content; and (4) whether it is possible to make purchases of goods/services through the application; and (5) is it possible to purchase virtual objects inside the application itself (in-app); and (6) liability measures of the parties, as well as other important provisions.
                                      
                                      Please note that some provisions of this document are set out in capital letters. This is done in order to draw the user's attention to important points concerning, for example, the limitation of the responsibility of application developers for this or that harm caused to the user for using the application and its content.
                                      
                                      
                                      Applicable law
                                      
                                      This User Agreement for the application has been developed in accordance with the current civil legislation of the Russian Federation, the norms of the Federal Law 'On Consumer Rights Protection', the norms of the Federal Law...
                                      """
        text.text = NSLocalizedString("TERMS_AND_CONDITIONS_MAIN_TEXT", comment: mainText)
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
