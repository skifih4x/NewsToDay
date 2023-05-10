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
    private let languageView = LanguageView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
