//
//  LastNewsViewCell.swift
//  NewsToDay
//
//  Created by mac on 5/9/23.
//

import UIKit
import SnapKit

class LastNewsViewCell: UICollectionViewCell {
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "ART"
        label.textColor = Resources.Colors.blackPrimary
        label.textAlignment = .left
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = Resources.Colors.blackPrimary
        label.textAlignment = .left
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let imageBookmark: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "")
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .gray
        layer.cornerRadius = 16
    }
    
    func configureCell(text: String) {
        titleLabel.text = text
    }
    
}

extension LastNewsViewCell {
    
    private func setupConstraints() {
        
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
    }
}
