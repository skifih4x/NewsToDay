//
//  ExtentionSearchHomeVC.swift
//  NewsToDay
//
//  Created by mac on 5/15/23.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        let article = news[indexPath.row]
        cell.configure(article: article)
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = news[indexPath.row]
        let detail = DatailVC()
        
    }
    
    */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

// MARK: - Search Delegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != "" {
            fetchSearchData(for: searchText)
        } else if searchBar.text?.count == 0 {
            news = []
            tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        tableView.isHidden = true
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
    
}

