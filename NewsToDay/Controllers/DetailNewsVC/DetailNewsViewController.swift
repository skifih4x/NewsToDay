//
//  DetailNewsViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation
import UIKit

class DatailVC: UIViewController    {
    
    var articleInfo: ArticleInfo?
    
    let stackView = UIStackView ()
    let scrollView = UIScrollView()
    let textOfNews = UILabel()
    let topLabel = UILabel()
    let authorNameLabel = UILabel()
    let categoryLabel = UILabel()
    let imageOfNews = UIImageView()
    
    let backButton = UIButton()
    let bookMark = UIButton()
    let forwardButton = UIButton()
    
    override func viewDidLoad() {
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.addSubview(stackView)
        
        scrollStackViewConfigure()
        stackViewConfigure()
        textViewConfigure()
        topViewConfigure ()
    }
    
    @objc private func bookmarkButtonPressed(_ sender: UIButton) {
        sender.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
    }
    
    @objc private func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    // Scroll&StackView Configure
    func scrollStackViewConfigure () {
        stackView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.frame = CGRect(x: 0, y: -60, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: textOfNews.frame.height)
    }
    
    // Image View Configure
    func stackViewConfigure () {
        imageOfNews.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 384)
        let defaultImage = UIImage(named: "newsImage")
        let articleImageView = UIImageView()
        
        if let urlToImageString = articleInfo?.image {
            if urlToImageString != "" {
                guard let url = URL(string: urlToImageString) else { return }
                articleImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "network"), options: [.continueInBackground,.progressiveLoad]) { _, _, _, _ in
                    self.imageOfNews.image = articleImageView.image
                }
            } else {
                self.imageOfNews.image = defaultImage
            }
        } else {
            self.imageOfNews.image = defaultImage
        }
        
        stackView.addSubview(imageOfNews)
        backButton.setImage(UIImage(named: "narrow"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        bookMark.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        bookMark.tintColor = .white
        bookMark.addTarget(self, action: #selector(bookmarkButtonPressed(_:)), for: .touchUpInside)
        
        forwardButton.setImage(UIImage(named: "forward"), for: .normal)
        
        imageOfNews.addSubview(backButton)
        imageOfNews.addSubview(bookMark)
        imageOfNews.addSubview(forwardButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        bookMark.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -337),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            backButton.topAnchor.constraint(equalTo: imageOfNews.topAnchor, constant: 74),
            backButton.bottomAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: -280),
            
            bookMark.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            bookMark.topAnchor.constraint(equalTo: imageOfNews.topAnchor, constant: 74),
            bookMark.heightAnchor.constraint(equalToConstant: 30),
            bookMark.widthAnchor.constraint(equalToConstant: 30),
            
            forwardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            forwardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 337),
            forwardButton.topAnchor.constraint(equalTo: imageOfNews.topAnchor, constant: 123),
            forwardButton.bottomAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: -233)
        ])
    }
    
    //Label Text View Configure
    func textViewConfigure () {
        stackView.addSubview(textOfNews)
        //        textOfNews.frame = CGRect(x: 0, y: 384, width: view.frame.width, height: 700)
        textOfNews.numberOfLines = 0
        textOfNews.textColor = UIColor(named: "gray")
        textOfNews.font = textOfNews.font.withSize(20)
        textOfNews.text = articleInfo?.content ?? "Article without content"
        textOfNews.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textOfNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textOfNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textOfNews.topAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: 24)
        ])
    }
    func topViewConfigure () {
        imageOfNews.addSubview(topLabel)
        imageOfNews.addSubview(authorNameLabel)
        imageOfNews.addSubview(bookMark)
        imageOfNews.addSubview(categoryLabel)
        
        categoryLabel.text = articleInfo?.category
        topLabel.text = articleInfo?.title
        authorNameLabel.text = articleInfo?.author ?? "Author unknown"
        
        topLabel.font = UIFont.boldSystemFont(ofSize: 25)
        authorNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        topLabel.textColor = .white
        authorNameLabel.textColor = .white
        categoryLabel.textColor = .white
        categoryLabel.layer.masksToBounds = true
        categoryLabel.layer.cornerRadius = 20
        categoryLabel.backgroundColor = UIColor (named: "purpleColor")
        categoryLabel.textAlignment = .center
        
        topLabel.numberOfLines = 4
        topLabel.adjustsFontSizeToFitWidth = true
        topLabel.minimumScaleFactor = 0.3
        
        authorNameLabel.numberOfLines = 2
        authorNameLabel.adjustsFontSizeToFitWidth = true
        authorNameLabel.minimumScaleFactor = 0.5
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([            
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(equalToConstant: 110),
            categoryLabel.topAnchor.constraint(equalTo: imageOfNews.topAnchor,constant: 130),
            categoryLabel.heightAnchor.constraint(equalToConstant: 40),
            
            topLabel.trailingAnchor.constraint(equalTo: imageOfNews.trailingAnchor, constant: -20),
            topLabel.leadingAnchor.constraint(equalTo: imageOfNews.leadingAnchor, constant: 20),
            topLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor,constant: 40),
            
            authorNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorNameLabel.bottomAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: -20),
        ])
    }
}
