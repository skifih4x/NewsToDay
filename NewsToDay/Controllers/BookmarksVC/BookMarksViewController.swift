//
//  BookMarksViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import UIKit

class BookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let vectorView: UIImageView = {
        let vector = UIImageView()
        vector.translatesAutoresizingMaskIntoConstraints = false
        vector.image = UIImage(named: "Vector")
        return vector
    }()
    
    let ellipseView: UIImageView = {
        let ellipse = UIImageView()
        ellipse.translatesAutoresizingMaskIntoConstraints = false
        ellipse.image = UIImage(named: "Ellipse 4")
        return ellipse
    }()
    
    let messageView: UILabel = {
        let message = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.text = "You haven't saved any articles yet. Start reading and bookmarking them now"
        message.font = UIFont.systemFont(ofSize: 16)
        message.numberOfLines = 3
        message.textColor = .black
        message.textAlignment = .center
        return message
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Bookmarks"
        title.font = UIFont.systemFont(ofSize: 24)
        title.textColor = .black
        title.textAlignment = .left
        return title
    }()
    
    let subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.text = "Saved articles to the library"
        subtitle.font = UIFont.systemFont(ofSize: 16)
        subtitle.textColor = .lightGray
        subtitle.textAlignment = .left
        return subtitle
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(ellipseView)
        view.addSubview(vectorView)
        view.addSubview(messageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = 0
        tableView.isHidden = numberOfRows == 0
        return numberOfRows

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            fatalError("Error")
        }
        cell.textLabel?.text = indexPath.row.description
//        cell.configure(img: <#T##UIImage#>, category: <#T##String#>, news: <#T##String#>)
        return cell
    }
    
}
    
    extension BookmarksViewController {
        
        func setConstraints() {
            NSLayoutConstraint.activate([
                vectorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                vectorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                ellipseView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                ellipseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                messageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                messageView.topAnchor.constraint(equalTo: ellipseView.bottomAnchor, constant: 24),
                messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
                messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -59),
                
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                
                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                
                tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        }
    }

