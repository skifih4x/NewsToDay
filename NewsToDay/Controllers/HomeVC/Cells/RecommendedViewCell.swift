//
//  RecommendedViewCell.swift
//  NewsToDay
//
//  Created by mac on 5/9/23.
//

import UIKit
import SnapKit

class RecommendedViewCell: UICollectionViewCell {
    
    var networkManadger = NetworkManager.shared
    
    // MARK: - UI Properties
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "ART"
        label.textColor = Resources.Colors.greyPrimary
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = Resources.Colors.blackPrimary
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.lineBreakStrategy = .standard
        label.textAlignment = .left
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 16
        backgroundColor = .white
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method for cell
    
    func configureCell(article: Article) {
        titleLabel.text = article.title
        categoryLabel.text = article.content
        
        DispatchQueue.global().async {
            guard let stringUrl = article.urlToImage else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
        
        //networkManadger.fetchImage(url: article.urlToImage ?? "", imageView: imageView)
        //imageView.image = UIImage(named: article.urlToImage ?? "")
    }
    
}

// MARK: - Extention, setup constraints

extension RecommendedViewCell {
    
    private func setupConstraints() {
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(96)
            make.width.equalTo(92)
        }
        
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
}
