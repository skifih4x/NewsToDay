//
//  HeaderReusableView.swift
//  NewsToDay
//
//  Created by mac on 5/9/23.
//

import UIKit
import SnapKit

class HeaderReusableView: UICollectionReusableView {
    
    // MARK: - UI Properties
        
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Resources.Colors.blackPrimary
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func confugure(name: String) {
        headerLabel.text = name
    }
    
    func setConstraints() {
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(10)
        }
    }
    
}
