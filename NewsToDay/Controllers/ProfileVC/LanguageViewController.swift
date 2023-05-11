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
}

// MARK: - LanguageViewDelegate
extension LanguageViewController: LanguageViewDelegate {
    
    func LanguageView(_ view: LanguageView, backButtonPressed button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
