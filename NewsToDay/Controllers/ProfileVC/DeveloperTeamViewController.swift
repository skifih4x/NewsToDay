//
//  TermsAndConditionsViewController.swift
//  NewsToDay
//
//  Created by Ilyas Tyumenev on 09.05.2023.
//

import UIKit
import SnapKit

class DeveloperTeamViewController: UIViewController {
    
    // MARK: - Private Properties
    private let developerTeamView = NewsToDay.DeveloperTeamView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        developerTeamView.delegate = self
        addViews()
        addConstraints()
    }
    
    // MARK: - Private Methods
    private func addViews() {
        view.backgroundColor = .white
        view.addSubview(developerTeamView)
    }
    
    private func addConstraints() {
        developerTeamView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - ProfileViewDelegate
extension DeveloperTeamViewController: DeveloperTeamViewDelegate {
    
    func DeveloperTeamView(_ view: DeveloperTeamView, backButtonPressed button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
