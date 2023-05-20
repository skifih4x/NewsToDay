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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self

        setImage()
        customView.categoryLabel.text = articleInfo?.category
        customView.topLabel.text = articleInfo?.title
        customView.authorNameLabel.text = articleInfo?.author ?? "Author unknown"
        customView.textOfNews.text = articleInfo?.content ?? "Article without content"
        
        updateHeightContentView()
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
        customView.contentViewHeightAnchor.constant = textSize.height + 384
        customView.layoutIfNeeded()
    }
}

extension DetailViewController: DetailViewDelegate {
    func DetailView(_ view: DetailView, backButtonPressed button: UIButton) {
        self.dismiss(animated: true)
    }
    
    func DetailView(_ view: DetailView, bookmarkButtonPressed button: UIButton) {
        
    }
    
    func DetailView(_ view: DetailView, forwardButtonPressed button: UIButton) {
        
    }
}
