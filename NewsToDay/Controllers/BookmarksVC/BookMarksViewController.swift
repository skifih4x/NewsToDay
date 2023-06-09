//
//  BookMarksViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import UIKit
import SDWebImage

class BookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var storageManager: StorageManagerProtocol = StorageManager()
    var bookmarks: [BookmarkModel] = []
    private let localizationManager = LocalizationManager.localizationManager
    
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
        message.font = UIFont.systemFont(ofSize: 16)
        message.numberOfLines = 0
        message.textColor = .black
        message.textAlignment = .center
        return message
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .boldSystemFont(ofSize: 24)
        title.textColor = Resources.Colors.blackPrimary
        title.textAlignment = .left
        return title
    }()
    
    let subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.font = UIFont.systemFont(ofSize: 16)
        subtitle.textColor = Resources.Colors.greyPrimary
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
        updateLocalizedStrings()
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
    
    private func updateLocalizedStrings() {
        localizationManager.localizeView("BOOKMARKS_MESSAGE_VIEW", view: messageView, updatingBlock: nil)
        localizationManager.localizeView("BOOKMARKS_TITLE_LABEL", view: titleLabel, updatingBlock: nil)
        localizationManager.localizeView("BOOKMARKS_SUBTITLE_LABEL", view: subtitleLabel, updatingBlock: nil)
        localizationManager.localizeView("BOOKMARKS_MESSAGE_VIEW", view: messageView, updatingBlock: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bookmarks = storageManager.retrieveAll()
        tableView.reloadData()
    }
    
    func edit(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Delete") { [weak self] (_,_, completionHandler) in
            let alert = UIAlertController(
                title: LocalizationManager.localizationManager.localizeString("BOOKMARKS_ALERT_TITLE"),
                message: "",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: LocalizationManager.localizationManager.localizeString("BOOKMARKS_CANCEL_ALERT_TITLE"),
                style: .cancel,
                handler: { (_) in
                    completionHandler(false)
                }))
            alert.addAction(UIAlertAction(
                title: LocalizationManager.localizationManager.localizeString("BOOKMARKS_DELETE_ALERT_TITLE"),
                style: .destructive,
                handler: { (_) in
                    self?.storageManager.deleteItem(by: self?.bookmarks[indexPath.row].url ?? "")
                    self?.bookmarks.remove(at: indexPath.row)
                    self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                    completionHandler(true)
            }))
            self?.present(alert, animated: true)
        }
        action.backgroundColor = .red
        return action
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = self.edit(rowIndexPath: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [edit])
        return swipe
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = bookmarks[indexPath.row]
        let articleInfo = ArticleInfo(
            title: article.title ?? "",
            category: article.category,
            author: article.author,
            image: article.urlToImage,
            content: article.content,
            link: article.url
        )
        
        let destination = DetailViewController()
        destination.articleInfo = articleInfo
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = bookmarks.count
        tableView.isHidden = numberOfRows == 0
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            fatalError("Error")
        }
        cell.delegate = self
        cell.tag = indexPath.row
        
        let defaultImage = UIImage(systemName: "photo")
        let articleImageView = UIImageView()
        
        if let urlToImageString = bookmarks[indexPath.row].urlToImage {
            if urlToImageString != "" {
                guard let url = URL(string: urlToImageString) else { return cell }
                articleImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "network"), options: [.continueInBackground,.progressiveLoad]) { _, _, _, _ in
                    cell.configure(img: articleImageView.image!,
                                   category: self.bookmarks[indexPath.row].category,
                                   news: self.bookmarks[indexPath.row].title ?? "")
                }
            } else {
                articleImageView.image = defaultImage
                cell.configure(img: articleImageView.image!,
                               category: bookmarks[indexPath.row].category,
                               news: bookmarks[indexPath.row].title ?? "")
            }
        } else {
            articleImageView.image = defaultImage
            cell.configure(img: articleImageView.image!,
                           category: bookmarks[indexPath.row].category,
                           news: bookmarks[indexPath.row].title ?? "")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
                
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
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

extension BookmarksViewController: CellDelegate {
    func buttonPressed(_ cell: CustomCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alert = UIAlertController(
            title: LocalizationManager.localizationManager.localizeString("BOOKMARKS_ALERT_TITLE"),
            message: "",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: LocalizationManager.localizationManager.localizeString("BOOKMARKS_CANCEL_ALERT_TITLE"),
            style: .cancel,
            handler: nil
        ))
        alert.addAction(UIAlertAction(
            title: LocalizationManager.localizationManager.localizeString("BOOKMARKS_DELETE_ALERT_TITLE"),
            style: .destructive,
            handler: { _ in
                self.storageManager.deleteItem(by: self.bookmarks[indexPath.row].url)
                self.bookmarks.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }))
        present(alert, animated: true, completion: nil)
    }
}
