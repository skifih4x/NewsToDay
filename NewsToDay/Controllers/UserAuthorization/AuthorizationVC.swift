//
//  ViewController.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

class AuthorizationViewController: CustomViewController<AuthorizationView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
    }
}

extension AuthorizationViewController: AuthorizationViewDelegate {
    func AuthorizationView(_ view: AuthorizationView, didTapButton button: UIButton) {
    }
}
