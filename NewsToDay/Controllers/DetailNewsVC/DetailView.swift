//
//  DetailView.swift
//  NewsToDay
//
//  Created by Andrey on 19.05.2023.
//

import Foundation
import UIKit

protocol DetailViewDelegate: AnyObject {
    func DetailView(_ view: DetailView, backButtonPressed button: UIButton)
    func DetailView(_ view: DetailView, bookmarkButtonPressed button: UIButton)
    func DetailView(_ view: DetailView, forwardButtonPressed button: UIButton)
}

class DetailView: CustomView {
    weak var delegate: DetailViewDelegate?
    
    //MARK: - Variables
    lazy var scrollView = UIScrollView()
    
    lazy var contentView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var imageOfNews: UIImageView = {
        let element = UIImageView()
        let defaultImage = UIImage(named: "newsImage")
        element.image = defaultImage
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var backButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(named: "narrow"), for: .normal)
        element.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var bookmarkButton: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        element.tintColor = .white
//        element.addTarget(self, action: #selector(bookmarkButtonPressed(_:)), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    lazy var forwardButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(named: "forward"), for: .normal)
        element.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    lazy var categoryLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.boldSystemFont(ofSize: 16)
        element.textColor = .white
        element.layer.masksToBounds = true
        element.layer.cornerRadius = 20
        element.backgroundColor = UIColor (named: "purpleColor")
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var topLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.boldSystemFont(ofSize: 25)
        element.textColor = .white
        element.numberOfLines = 4
        element.adjustsFontSizeToFitWidth = true
        element.minimumScaleFactor = 0.3
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    lazy var authorNameLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.boldSystemFont(ofSize: 18)
        element.textColor = .white
        element.numberOfLines = 2
        element.adjustsFontSizeToFitWidth = true
        element.minimumScaleFactor = 0.5
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var textOfNews: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.textColor = Resources.Colors.greyDark
        element.font = UIFont.systemFont(ofSize: 20)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        self.backgroundColor = .white
        
        scrollView.addSubview(contentView)
        contentView.addSubview(imageOfNews)
        contentView.addSubview(textOfNews)
        contentView.addSubview(backButton)
        contentView.addSubview(bookmarkButton)
        contentView.addSubview(forwardButton)
        contentView.addSubview(topLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(categoryLabel)
        
        self.addSubview(scrollView)
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 2000),
            
            imageOfNews.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageOfNews.heightAnchor.constraint(equalToConstant: 384),
            imageOfNews.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageOfNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageOfNews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: imageOfNews.leadingAnchor, constant: 25),
            backButton.topAnchor.constraint(equalTo: imageOfNews.topAnchor, constant: 75),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),

            bookmarkButton.trailingAnchor.constraint(equalTo: imageOfNews.trailingAnchor, constant: -25),
            bookmarkButton.topAnchor.constraint(equalTo: imageOfNews.topAnchor, constant: 75),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 40),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 40),

            forwardButton.trailingAnchor.constraint(equalTo: imageOfNews.trailingAnchor, constant: -26),
            forwardButton.topAnchor.constraint(equalTo: imageOfNews.topAnchor, constant: 125),
            forwardButton.heightAnchor.constraint(equalToConstant: 30),
            forwardButton.widthAnchor.constraint(equalToConstant: 30),

            categoryLabel.leadingAnchor.constraint(equalTo: imageOfNews.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(equalToConstant: 110),
            categoryLabel.topAnchor.constraint(equalTo: imageOfNews.topAnchor,constant: 130),
            categoryLabel.heightAnchor.constraint(equalToConstant: 40),

            topLabel.trailingAnchor.constraint(equalTo: imageOfNews.trailingAnchor, constant: -20),
            topLabel.leadingAnchor.constraint(equalTo: imageOfNews.leadingAnchor, constant: 20),
            topLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor,constant: 40),

            authorNameLabel.trailingAnchor.constraint(equalTo: imageOfNews.trailingAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: imageOfNews.leadingAnchor, constant: 20),
            authorNameLabel.bottomAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: -20),

            textOfNews.topAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: 10),
            textOfNews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            textOfNews.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            textOfNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textOfNews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
}

//MARK: - Target Actions
private extension DetailView {
    @objc func backButtonPressed(_ button: UIButton) {
        delegate?.DetailView(self, backButtonPressed: button)
    }
    
    @objc func bookmarkButtonPressed(_ button: UIButton) {
        delegate?.DetailView(self, bookmarkButtonPressed: button)
    }
    
    @objc func forwardButtonPressed(_ button: UIButton) {
        delegate?.DetailView(self, forwardButtonPressed: button)
    }
}
