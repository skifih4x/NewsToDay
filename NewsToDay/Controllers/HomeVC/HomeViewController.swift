//
//  ViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import UIKit
import SnapKit
import SDWebImage

final class HomeViewController: UIViewController, CategoriesDelegate {
    
    
    // MARK: - Variables and constants
    
    var timer: Timer?
    
    var networkManadger = NetworkManager.shared
    var categoryStorage = CategoriesStorage.shared
    var dataManager = DataManager.shared
    var storageManager: StorageManagerProtocol = StorageManager()

    var categories: Category?
    
    var news: [Article] = []
    var randomNews = [Article]()
    
    var selectedCategory: String?
    var isShowingSearchResults = false
    
   lazy var sections: [Section] = [.categories, .lastNews, .recommended]
    
    var selectedCategories: [String] = ["top"]
    
    // MARK: - UI Properties
    
    var collectionView: UICollectionView!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("HOME_TITLE_LABEL", comment: "Browse")
        label.textColor = Resources.Colors.blackPrimary
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("HOME_SUBTITLE_LABEL", comment: "Discover things of this world")
        label.textColor = Resources.Colors.greyPrimary
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        let sbar = UISearchBar()
        sbar.placeholder = NSLocalizedString("HOME_SEARCH_BAR", comment: "Search")
        sbar.searchBarStyle = .minimal
        sbar.delegate = self
        sbar.frame.size.height = 170
        return sbar
    }()
    
    lazy var tableView: UITableView = {
       let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 26, right: .zero)
        
       return table
    }()
    
// MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        configure()
        
        tableView.isHidden = true
        setupTableView()
        saveData()
        
        shuffleNews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isShowingSearchResults {
            tableView.isHidden = false
            collectionView.isHidden = true
        } else {
            tableView.isHidden = true
            collectionView.isHidden = false
        }
        
    }
    

    // MARK: - Shuffle news in recommended
    
    func shuffleNews() {
        randomNews = news.shuffled()
        collectionView.reloadSections(IndexSet(integer: 2))
    }
    
    // MARK: - Fetch data
    
    func fetchLatestNews(for category: [String]) {
        var categoriesToFetch: [String]
                
        if category.isEmpty {
                    categoriesToFetch = selectedCategories
                } else {
                    categoriesToFetch = category
                }
                
                
        networkManadger.fetchLatestNews(category: categoriesToFetch, country: Country.us) { [weak self] result in
                    switch result {
                    case .success(let newsModel):
                        self?.news = newsModel.results
                        
                        if let fetchNews = self?.news {
                            self?.dataManager.saveNews(fetchNews)
                        }
                        
                        DispatchQueue.main.async {
                            self?.collectionView.reloadSections(IndexSet(integer: 1))
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        
    }
    
    func saveData() {
        if let savedCategory = dataManager.loadSelectedCategory() {
            selectedCategory = savedCategory
        }
        
        if let savedNews = dataManager.loadData() {
            news = savedNews
        } else {
            if let categoryS = selectedCategory {
                fetchLatestNews(for: [categoryS])
            }
        }
        
    }

    func fetchSearchData(for searchText: String) {
        
        networkManadger.fetchSearch(searchText: searchText) { [weak self] result in
            switch result {
            case .success(let newsMod):
                self?.news = newsMod.results
                
                DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
    
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - setup Collection View
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        
        // Cells
        collectionView.register(CategoriesViewCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(LastNewsViewCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(RecommendedViewCell.self, forCellWithReuseIdentifier: "cell3")
        
        // Header
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        // CompositionLayout
        collectionView.collectionViewLayout = creatCompositionalLayout()
    
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupTableView() {
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        
    }
    
}

// MARK: - Extention, setup constraints

extension HomeViewController {
    private func configure() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(80)
            
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(70)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(3)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: LastNewsCellDelegate {
    func removeFromBookmarks(_ cell: LastNewsViewCell) {
            
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        self.storageManager.deleteItem(by: self.news[indexPath.row].link)
    }
    
    func addToBookmarks(_ cell: LastNewsViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        self.storageManager.save(article: news[indexPath.row])
    }
    
}

extension HomeViewController: RecommendedNewsCellDelegate {
    func removeFromBookmarks(_ cell: RecommendedViewCell) {
            
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        self.storageManager.deleteItem(by: self.news[indexPath.row].link)
    }
    
    func addToBookmarks(_ cell: RecommendedViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        self.storageManager.save(article: news[indexPath.row])
    }
    
}
    

