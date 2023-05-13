//
//  CustomUIButton.swift
//  NewsToDay
//
import UIKit

extension UIButton {
    
    func configure(title: String, height: CGFloat = 60) {
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        tintColor = .white
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17)
        backgroundColor = UIColor(named: "purpleColor")
        
    }
}
