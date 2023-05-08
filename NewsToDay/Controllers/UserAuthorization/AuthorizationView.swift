//
//  AuthorizationView.swift
//  NewsToDay
//
//  Created by Andrey on 08.05.2023.
//

import UIKit

protocol AuthorizationViewDelegate: AnyObject {
    func AuthorizationView(_ view: AuthorizationView, didTapSignInButton button: UIButton)
    func AuthorizationView(_ view: AuthorizationView, didTapCreateAccountButton button: UIButton)
}

class AuthorizationView: CustomView {
    weak var delegate: AuthorizationViewDelegate?
    
    //MARK: - Variables
    private lazy var topLabel: UILabel = {
        let element = UILabel()
        element.text = "Welcome Back"
        element.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        element.textColor = .label
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var greetingLabel: UILabel = {
        let element = UILabel()
        element.text = "I am happy to see you again. You can continue where you left off by logging in"
        element.font = UIFont.systemFont(ofSize: <#Int#>)
        element.textColor = <#UIColor#>
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //Email and passwerd fields
    
    private lazy var signInButton: UIButton = {
        let element = UIButton()
        element.restorationIdentifier = <#String#>
        element.backgroundColor = <#UIColor#>
        element.setTitle(<#String#>, for: .normal)
        element.setTitleColor(<#UIColor#>, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: <#Int#>)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapSignInButton(_:)), for: .touchUpInside)
        return element
    }()
    
    private lazy var createAccountHStack: UIStackView = {
        let element = UIStackView()
        element.axis = <#axis#>
        element.spacing = <#Int#>
        element.distribution = <#distribution#>
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var createAccountLabel: UILabel = {
        let element = UILabel()
        element.text = <#String#>
        element.font = UIFont.systemFont(ofSize: <#Int#>)
        element.textColor = <#UIColor#>
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var createAccountButton: UIButton = {
        let element = UIButton()
        element.restorationIdentifier = <#String#>
        element.backgroundColor = <#UIColor#>
        element.setTitle(<#String#>, for: .normal)
        element.setTitleColor(<#UIColor#>, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: <#Int#>)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapCreateAccountButton(_:)), for: .touchUpInside)
        return element
    }()
    
    
    
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
    @objc func didTapSignInButton(_ button: UIButton) {
        delegate?.AuthorizationView(self, didTapSignInButton: button)
    }
    
    @objc func didTapCreateAccountButton(_ button: UIButton) {
        delegate?.AuthorizationView(self, didTapCreateAccountButton: button)
    }
    
}
