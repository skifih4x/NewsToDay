//
//  AuthorizationView.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

protocol AuthorizationViewDelegate: AnyObject {
    func AuthorizationView(_ view: AuthorizationView, didTapButton button: UIButton)
}

class AuthorizationView: CustomView {
    weak var delegate: AuthorizationViewDelegate?
    
    //MARK: - Variables
    // Add private lazy variables here
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        // Add subviews here
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        // Add constraints here
    }
}

//MARK: - Target Actions
private extension AuthorizationView {
    @objc func didTapButton(_ button: UIButton) {
        delegate?.AuthorizationView(self, didTapButton: button)
    }
}
