//
//  View.swift
//  ProjectName
//
//  Created by Andrey on dd.mm.yyyy.
//

import UIKit

class CustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
        layoutViews()
    }

    /// Set your view and its subviews here.
    func setViews() {
        backgroundColor = .systemBackground
    }

    /// Layout your subviews here.
    func layoutViews() {}
    
}
