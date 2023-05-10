//
//  RecommendedViewCell.swift
//  NewsToDay
//
//  Created by mac on 5/9/23.
//

import UIKit
import SnapKit

class RecommendedViewCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "ART"
        label.textColor = Resources.Colors.blackPrimary
        label.textAlignment = .left
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupView() {
        backgroundColor = .gray
        addSubview(titleLabel)
    }
    
    func configureCell(text: String) {
        titleLabel.text = text
    }
    
}

extension RecommendedViewCell {
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
}
