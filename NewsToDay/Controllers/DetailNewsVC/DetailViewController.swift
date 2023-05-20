//
//  DetailViewController.swift
//  NewsToDay
//
//  Created by Andrey on 19.05.2023.
//

import Foundation
import UIKit

class DetailViewController: CustomViewController<DetailView> {
    
    var articleInfo: ArticleInfo?
    var storageManager: StorageManagerProtocol = StorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self

        setImage()
        customView.categoryLabel.text = articleInfo?.category
        customView.topLabel.text = articleInfo?.title
        customView.authorNameLabel.text = articleInfo?.author ?? "Author unknown"
        customView.textOfNews.text = articleInfo?.content ?? "Article without content"
        
        updateHeightContentView()
        configureBookmarkButton()
    }
    
    func setImage() {
        let defaultImage = UIImage(named: "newsImage")
        
        if let urlToImageString = articleInfo?.image {
            if urlToImageString != "" {
                guard let url = URL(string: urlToImageString) else { return }
                customView.imageOfNews.sd_setImage(with: url, placeholderImage: UIImage(systemName: "network"), options: [.continueInBackground,.progressiveLoad]) { _, _, _, _ in
                }
            } else {
                customView.imageOfNews.image = defaultImage
            }
        } else {
            customView.imageOfNews.image = defaultImage
        }
    }
    
    func updateHeightContentView() {
        let textSize = customView.textOfNews.sizeThatFits(CGSize(width: UIScreen.main.bounds.size.width - 40, height: CGFloat.greatestFiniteMagnitude))
        if textSize.height > UIScreen.main.bounds.size.height {
            customView.contentViewHeightAnchor.constant = textSize.height + 384
            customView.layoutIfNeeded()
        }
    }
    
    func configureBookmarkButton() {
        let articleLink = articleInfo?.link ?? ""
        let hasInRealm = storageManager.hasObjectInStorage(with: articleLink)
        if hasInRealm {
            customView.bookmarkButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            customView.bookmarkButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
}

extension DetailViewController: DetailViewDelegate {
    func DetailView(_ view: DetailView, backButtonPressed button: UIButton) {
        self.dismiss(animated: true)
    }
    
    func DetailView(_ view: DetailView, bookmarkButtonPressed button: UIButton) {
        if button.currentBackgroundImage == UIImage(systemName: "bookmark") {
            button.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            let article = Article(title: articleInfo?.title ?? "",
                                  keywords: nil,
                                  link: articleInfo?.link ?? "",
                                  creator: [articleInfo?.author ?? ""],
                                  videoUrl: nil,
                                  description: nil,
                                  content: articleInfo?.content,
                                  pubDate: "",
                                  urlToImage: articleInfo?.image,
                                  sourceID: "",
                                  category: [articleInfo?.category ?? ""],
                                  country: [""],
                                  language: "")
            storageManager.save(article: article)
        } else {
            button.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            storageManager.deleteItem(by: articleInfo?.link ?? "")
        }
    }
}
