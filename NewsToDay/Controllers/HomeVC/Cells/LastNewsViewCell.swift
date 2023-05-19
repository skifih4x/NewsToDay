//
//  LastNewsViewCell.swift
//  NewsToDay
//
//  Created by mac on 5/9/23.
//

import UIKit
import SnapKit

protocol LastNewsCellDelegate: AnyObject {
    func addToBookmarks(_ cell: LastNewsViewCell)
    func removeFromBookmarks(_ cell: LastNewsViewCell)
}

class LastNewsViewCell: UICollectionViewCell {
    
    weak var delegate: LastNewsCellDelegate?
    var networkManadger = NetworkManager.shared
    let image = UIImage(systemName: "bookmark")
    
    // MARK: - Properties
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.blackPrimary
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = Resources.Colors.purpleLight
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.blackPrimary
        label.numberOfLines = 4
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.clipsToBounds = false
        let attributeText = NSMutableAttributedString(string: label.text ?? "")
        let range = NSRange(location: 0, length: attributeText.length)
        
        label.attributedText = attributeText
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(bookmarkButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc private func bookmarkButtonPressed(_ sender: UIButton) {
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
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupView() {
        backgroundColor = .systemGray
        layer.cornerRadius = 16
    }
    
    func configureCell(article: Article, isTintedBookmark: Bool) {
        titleLabel.text = article.title
        categoryLabel.text = article.category.joined(separator: ", ")
        
        networkManadger.fetchImage(url: article.urlToImage ?? "", imageView: imageView)
        if isTintedBookmark {
            bookmarkButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            bookmarkButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
}

// MARK: - Extention, setup constraints

extension LastNewsViewCell {
    
    private func setupConstraints() {
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-150)
            
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        addSubview(bookmarkButton)
        bookmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
}
