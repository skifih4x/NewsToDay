//
//  BookMarksTableViewCell.swift
//  NewsToDay
//
//  Created by Mikhail Liubov on 09/05/2023.
//

import UIKit

protocol CellDelegate: AnyObject {
    func buttonPressed(_ cell: CustomCell)
}

class CustomCell: UITableViewCell {
    
    weak var delegate: CellDelegate?
    
    static let identifier = "CustomCell"
    
    private let cellImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        return image
    }()
    
    private let cellCategoryLabel: UILabel = {
        let category = UILabel()
        category.textAlignment = .left
        category.font = UIFont.systemFont(ofSize: 14)
        category.textColor = .lightGray
        category.numberOfLines = 1
        category.text = "Something went wrong"
        return category
    }()
    
    private let cellNewsLabel: UILabel = {
        let news = UILabel()
        news.textAlignment = .left
        news.font = UIFont.systemFont(ofSize: 16)
        news.textColor = .black
        news.numberOfLines = 2
        news.text = "We cant find your saved articles right now"
        return news
    }()
    
    private lazy var unmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(unmarkButtonPressed), for: .touchUpInside)
        return button
    }()
  
    @objc private func unmarkButtonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(self)
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(img image: UIImage, category categoryLabel: String, news newsLabel: String) {
        cellImageView.image = image
        cellCategoryLabel.text = categoryLabel
        cellNewsLabel.text = newsLabel
    }
    
    private func setupUI() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellCategoryLabel)
        contentView.addSubview(cellNewsLabel)
        contentView.addSubview(unmarkButton)
        
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        cellNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        unmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            cellImageView.heightAnchor.constraint(equalToConstant: 96),
            cellImageView.widthAnchor.constraint(equalToConstant: 96),
            
            cellCategoryLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 16),
            cellCategoryLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            
            cellNewsLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 16),
            cellNewsLabel.topAnchor.constraint(equalTo: cellCategoryLabel.bottomAnchor, constant: 8),
            cellNewsLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            unmarkButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            unmarkButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
