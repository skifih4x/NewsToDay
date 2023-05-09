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
    private let termsAndConditionsView = TermsAndConditionsView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
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
}
