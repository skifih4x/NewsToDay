//
//  ExtentionHomeVC.swift
//  NewsToDay
//
//  Created by mac on 5/8/23.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
            
        case .categories(let category):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? CategoriesViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configureCell(text: category[indexPath.row].title)
            return cell
            
        case .new(let new):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? LastNewsViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configureCell(text: new[indexPath.row].title)
            return cell
        case .recommended(let recommended):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as? RecommendedViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configureCell(text: recommended[indexPath.row].title)
            return cell
        }
        
        /*
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
        cell.backgroundColor = .blue
         */
    }
    
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
