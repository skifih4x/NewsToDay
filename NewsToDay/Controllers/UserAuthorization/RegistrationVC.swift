//
//  RegistrationViewController.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

class RegistrationViewController: CustomViewController<RegistrationView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
    }
}

extension RegistrationViewController: RegistrationViewDelegate {
    func RegistrationView(_ view: RegistrationView, didTapButton button: UIButton) {
    }
}
