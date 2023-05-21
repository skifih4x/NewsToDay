//
//  TermsAndConditionsView.swift
//  NewsToDay
//
//  Created by Ilyas Tyumenev on 09.05.2023.
//

import UIKit
import SnapKit

protocol DeveloperTeamViewDelegate: AnyObject {
    func developerTeamView(_ view: DeveloperTeamView, backButtonPressed button: UIButton)
}

class DeveloperTeamView: UIView {
    
    weak var delegate: DeveloperTeamViewDelegate?
    
    let backButton: UIButton = {
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
    
    let artemImageView: UIImageView = {
        let image = UIImageView()
        image.image = Resources.DeveloperTeamPhoto.Artem
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 36
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let artemLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 16)
        element.textColor = Resources.Colors.greyPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let antonImageView: UIImageView = {
        let image = UIImageView()
        image.image = Resources.DeveloperTeamPhoto.Anton
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 36
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let antonLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 16)
        element.textColor = Resources.Colors.greyPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let albinaImageView: UIImageView = {
        let image = UIImageView()
        image.image = Resources.DeveloperTeamPhoto.Albina
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 36
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let albinaLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 16)
        element.textColor = Resources.Colors.greyPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let ramilImageView: UIImageView = {
        let image = UIImageView()
        image.image = Resources.DeveloperTeamPhoto.Ramil
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 36
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let ramilLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 16)
        element.textColor = Resources.Colors.greyPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let ilyasImageView: UIImageView = {
        let image = UIImageView()
        image.image = Resources.DeveloperTeamPhoto.Ilyas
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 36
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let ilyasLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 16)
        element.textColor = Resources.Colors.greyPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let mihailImageView: UIImageView = {
        let image = UIImageView()
        image.image = Resources.DeveloperTeamPhoto.Mihail
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 36
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let mikhailLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 16)
        element.textColor = Resources.Colors.greyPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let andreyImageView: UIImageView = {
        let image = UIImageView()
        image.image = Resources.DeveloperTeamPhoto.Andrey
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 36
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let andreyLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 16)
        element.textColor = Resources.Colors.greyPrimary
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
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
        addSubview(artemLabel)
        addSubview(artemImageView)
        addSubview(antonLabel)
        addSubview(antonImageView)
        addSubview(albinaLabel)
        addSubview(albinaImageView)
        addSubview(ramilLabel)
        addSubview(ramilImageView)
        addSubview(ilyasLabel)
        addSubview(ilyasImageView)
        addSubview(mikhailLabel)
        addSubview(mihailImageView)
        addSubview(andreyLabel)
        addSubview(andreyImageView)
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
        
        NSLayoutConstraint.activate([
            artemImageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            artemImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            artemImageView.heightAnchor.constraint(equalToConstant: 72),
            artemImageView.widthAnchor.constraint(equalToConstant: 72),
            
            artemLabel.centerYAnchor.constraint(equalTo: artemImageView.centerYAnchor),
            artemLabel.leadingAnchor.constraint(equalTo: artemImageView.trailingAnchor, constant: 10),
            artemLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            antonImageView.topAnchor.constraint(equalTo: artemImageView.bottomAnchor, constant: 20),
            antonImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            antonImageView.heightAnchor.constraint(equalToConstant: 72),
            antonImageView.widthAnchor.constraint(equalToConstant: 72),
            
            antonLabel.centerYAnchor.constraint(equalTo: antonImageView.centerYAnchor),
            antonLabel.leadingAnchor.constraint(equalTo: antonImageView.trailingAnchor, constant: 10),
            antonLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            albinaImageView.topAnchor.constraint(equalTo: antonImageView.bottomAnchor, constant: 20),
            albinaImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            albinaImageView.heightAnchor.constraint(equalToConstant: 72),
            albinaImageView.widthAnchor.constraint(equalToConstant: 72),
            
            albinaLabel.centerYAnchor.constraint(equalTo: albinaImageView.centerYAnchor),
            albinaLabel.leadingAnchor.constraint(equalTo: albinaImageView.trailingAnchor, constant: 10),
            albinaLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            ramilImageView.topAnchor.constraint(equalTo: albinaImageView.bottomAnchor, constant: 20),
            ramilImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            ramilImageView.heightAnchor.constraint(equalToConstant: 72),
            ramilImageView.widthAnchor.constraint(equalToConstant: 72),
            
            ramilLabel.centerYAnchor.constraint(equalTo: ramilImageView.centerYAnchor),
            ramilLabel.leadingAnchor.constraint(equalTo: ramilImageView.trailingAnchor, constant: 10),
            ramilLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            ilyasImageView.topAnchor.constraint(equalTo: ramilImageView.bottomAnchor, constant: 20),
            ilyasImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            ilyasImageView.heightAnchor.constraint(equalToConstant: 72),
            ilyasImageView.widthAnchor.constraint(equalToConstant: 72),
            
            ilyasLabel.centerYAnchor.constraint(equalTo: ilyasImageView.centerYAnchor),
            ilyasLabel.leadingAnchor.constraint(equalTo: ilyasImageView.trailingAnchor, constant: 10),
            ilyasLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            mihailImageView.topAnchor.constraint(equalTo: ilyasImageView.bottomAnchor, constant: 20),
            mihailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            mihailImageView.heightAnchor.constraint(equalToConstant: 72),
            mihailImageView.widthAnchor.constraint(equalToConstant: 72),
            
            mikhailLabel.centerYAnchor.constraint(equalTo: mihailImageView.centerYAnchor),
            mikhailLabel.leadingAnchor.constraint(equalTo: mihailImageView.trailingAnchor, constant: 10),
            mikhailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            andreyImageView.topAnchor.constraint(equalTo: mihailImageView.bottomAnchor, constant: 20),
            andreyImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            andreyImageView.heightAnchor.constraint(equalToConstant: 72),
            andreyImageView.widthAnchor.constraint(equalToConstant: 72),
            
            andreyLabel.centerYAnchor.constraint(equalTo: andreyImageView.centerYAnchor),
            andreyLabel.leadingAnchor.constraint(equalTo: andreyImageView.trailingAnchor, constant: 10),
            andreyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
}

// MARK: - Target Actions
private extension DeveloperTeamView {
    
    @objc func backButtonPressed(_ button: UIButton) {
        delegate?.developerTeamView(self, backButtonPressed: button)
    }
}
