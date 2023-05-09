//
//  ProfileViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Private Properties
    private let profilelView = ProfileView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
    }
    
    // MARK: - Private Methods
    private func addViews() {
        view.backgroundColor = .white
        view.addSubview(profilelView)
    }
    
    private func addConstraints() {
        profilelView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}
