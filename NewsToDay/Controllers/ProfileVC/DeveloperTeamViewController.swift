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
    private let localizationManager = LocalizationManager.localizationManager
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        developerTeamView.delegate = self
        addViews()
        addConstraints()
        updateLocalizedStrings()
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
    
    private func updateLocalizedStrings() {
        localizationManager.localizeView("DEVELOPER_HEADER_LABEL", view: developerTeamView.headerLabel, updatingBlock: nil)
        localizationManager.localizeView("DEVELOPER_ARTEM_LABEL", view: developerTeamView.artemLabel, updatingBlock: nil)
        localizationManager.localizeView("DEVELOPER_ANTON_LABEL", view: developerTeamView.antonLabel, updatingBlock: nil)
        localizationManager.localizeView("DEVELOPER_ALBINA_LABEL", view: developerTeamView.albinaLabel, updatingBlock: nil)
        localizationManager.localizeView("DEVELOPER_RAMIL_LABEL", view: developerTeamView.ramilLabel, updatingBlock: nil)
        localizationManager.localizeView("DEVELOPER_ILYAS_LABEL", view: developerTeamView.ilyasLabel, updatingBlock: nil)
        localizationManager.localizeView("DEVELOPER_MIKHAIL_LABEL", view: developerTeamView.mikhailLabel, updatingBlock: nil)
        localizationManager.localizeView("DEVELOPER_ANDREY_LABEL", view: developerTeamView.andreyLabel, updatingBlock: nil)
    }
}

// MARK: - ProfileViewDelegate
extension DeveloperTeamViewController: DeveloperTeamViewDelegate {
    
    func developerTeamView(_ view: DeveloperTeamView, backButtonPressed button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
