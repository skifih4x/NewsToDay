//
//  SearchCell.swift
//  NewsToDay
//
//  Created by mac on 5/15/23.
//

import UIKit
import SnapKit

class SearchCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SearchCell"
    
    var networkManadger = NetworkManager.shared
    
    // MARK: - UI Properties
    
    private let imageNews: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    private let categoryLabel: UILabel = {
        let category = UILabel()
        category.textAlignment = .left
        category.font = UIFont.systemFont(ofSize: 14)
        category.textColor = .lightGray
        category.numberOfLines = 1
        category.text = "Something went wrong"
        return category
    }()
    
    private let newsLabel: UILabel = {
        let news = UILabel()
        news.textAlignment = .left
        news.font = UIFont.systemFont(ofSize: 16)
        news.textColor = .black
        news.numberOfLines = 2
        news.text = "We cant find your saved articles right now"
        return news
    }()
    
    //MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = Resources.Colors.greyLighter.cgColor
        layer.borderWidth = 1
        
    }
    
    // MARK: - Methods
    
    func configure(article: Article) {
        newsLabel.text = article.title
        categoryLabel.text = article.author

        networkManadger.fetchImage(url: article.urlToImage ?? "", imageView: imageNews)
  
    }
    
}

extension SearchCell {
    
    private func setupConstraints() {
        
        addSubview(imageNews)
        imageNews.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(96)
            make.width.equalTo(96)
        }
        
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalTo(imageNews.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-3)
        }
        
        addSubview(newsLabel)
        newsLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.equalTo(imageNews.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-3)
        }
    }
    
}

