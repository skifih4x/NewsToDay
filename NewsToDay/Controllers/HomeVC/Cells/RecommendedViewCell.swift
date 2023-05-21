//
//  RecommendedViewCell.swift
//  NewsToDay
//
//  Created by mac on 5/9/23.
//

import UIKit
import SnapKit

protocol RecommendedNewsCellDelegate: AnyObject {
    func addToBookmarks(_ cell: RecommendedViewCell)
    func removeFromBookmarks(_ cell: RecommendedViewCell)
}

class RecommendedViewCell: UICollectionViewCell {
    
    weak var delegate: RecommendedNewsCellDelegate?
    var networkManadger = NetworkManager.shared
    
    // MARK: - UI Properties
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "ART"
        label.textColor = Resources.Colors.greyPrimary
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = Resources.Colors.blackPrimary
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 3
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
    
    lazy private var buttonBookmark: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = Resources.Colors.blackDark
        button.addTarget(self, action: #selector(buttonBookmarkIspressed), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonBookmarkIspressed(_ sender: UIButton) {
        if sender.currentBackgroundImage == UIImage(systemName: "bookmark") {
            sender.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            delegate?.addToBookmarks(self)
        } else {
            sender.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            delegate?.removeFromBookmarks(self)
        }
    }
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    // MARK: - Method for cell
   
    func configureCell(article: Article, isTintedBookmark: Bool) {
        titleLabel.text = article.title
        if let creator = article.creator {
            categoryLabel.text = creator[0]
        }
        networkManadger.fetchImage(url: article.urlToImage ?? "", imageView: imageView)
        if isTintedBookmark {
            buttonBookmark.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            buttonBookmark.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        }
  
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
            make.top.equalToSuperview().offset(6)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-3)
        }
        
        addSubview(buttonBookmark)
        buttonBookmark.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
}
