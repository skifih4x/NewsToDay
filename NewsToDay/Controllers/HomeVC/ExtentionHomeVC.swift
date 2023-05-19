//
//  ExtentionHomeVC.swift
//  NewsToDay
//
//  Created by mac on 5/8/23.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        switch sections[section] {
        case .categories:
            return categoryStorage.categories.count
        case .lastNews:
            return news.count
        case .recommended:
            return news.count
        }
         
    }
    
    // MARK: - Delegate
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
            
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? CategoriesViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(text: categoryStorage.categories[indexPath.item])
            return cell
            
        case .lastNews:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? LastNewsViewCell
            else {
                return UICollectionViewCell()
            }
        
            let article = news[indexPath.item]
            cell.configureCell(article: article)
    
            return cell
            
        case .recommended:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as? RecommendedViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(article: news[indexPath.item])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         let section = sections[indexPath.section]
        
        switch section {
            
        case .categories:
            let categorySelect  = categoryStorage.categories[indexPath.item]
            fetchLatestNews(for: [categorySelect])
            
        case .lastNews:
            let selectedArticle: Article
            if section == .lastNews {
                selectedArticle = news[indexPath.item]
            } else {
                selectedArticle = news[indexPath.item]
            }
            
        case .recommended:
            let selectedArticle: Article
            if section == .recommended {
                selectedArticle = news[indexPath.item]
            } else {
                selectedArticle = news[indexPath.item]
            }
            
        navigareToDetail(with: selectedArticle)
        }
    }

    func navigareToDetail(with article: Article) {
        let articleInfo = ArticleInfo(
            title: article.title,
            category: article.category.joined(separator: ", "),
            //autor: article.creator,
            image: article.urlToImage,
            content: article.content
        )
        
        let detailVC = DatailVC()
        detailVC.articleInfo = articleInfo
        
        present(detailVC, animated: true)
        
    }

    // MARK: - Configure for header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderReusableView
            
            header.confugure(name: sections[indexPath.section].title )
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension HomeViewController {
    
    // MARK: - CompositionLayout
    
    func creatCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
                
            case .categories:
                return self.createCaregorySection()
            case .lastNews:
                return self.createLastNewsSection()
            case .recommended:
                return self.createRecommendedSection()
            }
        }
    }
    
    // MARK: - Create sections
    
    func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    func createCaregorySection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .absolute(110),
            heightDimension: .absolute(45)),subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 16,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 5, leading: 16, bottom: 24 , trailing: 0)
        
        return section
        
    }
    
    func createLastNewsSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .absolute(256),
            heightDimension: .absolute(256)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: -10)
        return section
        
    }
    
    func createRecommendedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(110))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 40, leading: 16, bottom: 0, trailing: 16)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
        
    }
    
    // MARK: - Method for header for recommended section
    
    func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(30)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
    
}
