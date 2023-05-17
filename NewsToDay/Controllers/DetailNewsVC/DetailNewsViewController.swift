//
//  DetailNewsViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import Foundation
import UIKit


class DatailVC: UIViewController {
    
    let stackView = UIStackView ()
    let scrollView = UIScrollView()
    let textOfNews = UILabel()
    let topLabel = UILabel()
    let authorNameLabel = UILabel()
    let authorLabel = UILabel()
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
    
    // Scroll&StackView Configure
    
    func scrollStackViewConfigure () {
     
        stackView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.frame = CGRect(x: 0, y: -60, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height * 1.3)
       
        
      
        
    }
    // Image View Configure
    
    @objc private func bookmarkButtonPressed(_ sender: UIButton) {
        sender.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
    }
    
    func stackViewConfigure () {
        imageOfNews.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 384)
        imageOfNews.image = UIImage(named: "newsImage")
        
        stackView.addSubview(imageOfNews)
        backButton.setImage(UIImage(named: "narrow"), for: .normal)
        bookMark.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        bookMark.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        bookMark.tintColor = .gray
        bookMark.addTarget(self, action: #selector(bookmarkButtonPressed), for: .touchUpInside)
        
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
            bookMark.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 337),
            bookMark.topAnchor.constraint(equalTo: imageOfNews.topAnchor, constant: 74),
            bookMark.bottomAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: -280),
            
           forwardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
           forwardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 337),
           forwardButton.topAnchor.constraint(equalTo: imageOfNews.topAnchor, constant: 123),
           forwardButton.bottomAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: -233),
           
        ])
    }
    
    
    //Label Text View Configure
    
    func textViewConfigure () {
        stackView.addSubview(textOfNews)
//        textOfNews.frame = CGRect(x: 0, y: 384, width: view.frame.width, height: 700)
        textOfNews.numberOfLines = 0
        textOfNews.textColor = UIColor(named: "gray")
        textOfNews.font = textOfNews.font.withSize(20)
        textOfNews.text = """
       
       Results
       
       Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races.
       
       For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters.
       
       Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races.For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters.
       
       """
        textOfNews.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textOfNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textOfNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textOfNews.topAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: 24),
           
        ])
      
    }
    func topViewConfigure () {
        imageOfNews.addSubview(topLabel)
        imageOfNews.addSubview(authorNameLabel)
        imageOfNews.addSubview(authorLabel)
        imageOfNews.addSubview(bookMark)
        imageOfNews.addSubview(categoryLabel)
        
        categoryLabel.text = "Politics"
        topLabel.text = "The latest situation in the \npresidential election"
        authorNameLabel.text = "John Doe"
        authorLabel.text = "Autor"
       
        
        topLabel.font = UIFont.boldSystemFont(ofSize: 25)
        authorNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        topLabel.textColor = .white
        authorNameLabel.textColor = .white
        categoryLabel.textColor = .white
        categoryLabel.layer.masksToBounds = true
        categoryLabel.layer.cornerRadius = 20
        authorLabel.textColor = .gray
        categoryLabel.backgroundColor = UIColor (named: "purpleColor")
        categoryLabel.textAlignment = .center
        
        
        topLabel.numberOfLines = 2
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -280),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.topAnchor.constraint(equalTo: imageOfNews.topAnchor,constant: 165),
            categoryLabel.bottomAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: -180),
            
            topLabel.trailingAnchor.constraint(equalTo: imageOfNews.trailingAnchor, constant: 19),
            topLabel.leadingAnchor.constraint(equalTo: imageOfNews.leadingAnchor, constant: 20),
            topLabel.topAnchor.constraint(equalTo: imageOfNews.topAnchor,constant: 216),
            topLabel.bottomAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: -96),
            
            authorNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorNameLabel.topAnchor.constraint(equalTo: imageOfNews.topAnchor,constant: 296),
            authorNameLabel.bottomAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: -64),
            
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorLabel.topAnchor.constraint(equalTo: imageOfNews.topAnchor,constant: 320),
            authorLabel.bottomAnchor.constraint(equalTo: imageOfNews.bottomAnchor, constant: -40),
        ])
    }
            }
