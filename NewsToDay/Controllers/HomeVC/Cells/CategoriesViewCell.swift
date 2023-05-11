//
//  CategoriesViewCell.swift
//  NewsToDay
//
//  Created by mac on 5/9/23.
//

import UIKit
import SnapKit

class CategoriesViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = Resources.Colors.greyPrimary
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.backgroundColor = Resources.Colors.purpleLight.cgColor
                titleLabel.textColor = .white
            } else {
                titleLabel.textColor = Resources.Colors.greyPrimary
                layer.backgroundColor = Resources.Colors.greyLighter.cgColor
            }
        }
    }
    
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
        backgroundColor = Resources.Colors.greyLighter
        layer.cornerRadius = 16
        addSubview(titleLabel)
    }
    
    func configureCell(text: String) {
        titleLabel.text = text
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
}
