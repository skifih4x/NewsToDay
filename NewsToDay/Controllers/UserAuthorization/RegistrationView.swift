//
//  RegistrationView.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func RegistrationView(_ view: RegistrationView, didTapButton button: UIButton)
}

class RegistrationView: CustomView {
    weak var delegate: RegistrationViewDelegate?
    
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
private extension RegistrationView {
    @objc func didTapButton(_ button: UIButton) {
        delegate?.RegistrationView(self, didTapButton: button)
    }
}
