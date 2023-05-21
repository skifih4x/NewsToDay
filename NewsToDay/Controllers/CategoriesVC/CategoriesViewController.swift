//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import UIKit

final class CategoriesViewController: UIViewController {
    private lazy var categoryView: CategoriesView = {
        let view = CategoriesView()

        view.collectionView?.delegate = self
        view.collectionView?.dataSource = self
        view.collectionView?.register(
            ButtonCell.self,
            forCellWithReuseIdentifier: "ButtonCell"
        )

        return view
    }()

    private let constants = CategoryConstants()
    private let categoriesStorage = CategoriesStorage.shared
    private let categories = Category.categories
    private let firebaseManager = FirebaseManager.shared

    var delegate: CategoriesDelegate?
    var category: String?
    

    init(isFirstEnter: Bool) {
        super.init(nibName: nil, bundle: nil)
        configureView(isFirstEnter: isFirstEnter)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view = categoryView
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoriesStorage.updateCategoryList()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        FirebaseManager.shared.saveCategoriesInDatabase(categories: categoriesStorage.categories)
    }

    @objc
    private func nextButtonTapped() {
        //Save in Firebase
        firebaseManager.saveCategoriesInDatabase(categories: categoriesStorage.categories)
        
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true)
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        categories.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ButtonCell",
            for: indexPath
        ) as? ButtonCell else {
            return UICollectionViewCell()
        }

        cell.set(title: categoryView.getCategories()[indexPath.row])

        let itemDidSelected = categoriesStorage.categories.first {
            $0 == categories[indexPath.row]
        }
        if itemDidSelected != nil {
            collectionView.selectItem(
                at: indexPath,
                animated: true,
                scrollPosition: .centeredVertically
            )
            cell.activate()
        }

        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(
            at: indexPath
        ) as? ButtonCell else { return }

        categoriesStorage.set(category: categories[indexPath.row])
        cell.activate()
        delegate?.fetchLatestNews(for: categoriesStorage.categories)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(
            at: indexPath
        ) as? ButtonCell else { return }

        categoriesStorage.delete(category: categories[indexPath.row])
        cell.deactivate()
        delegate?.fetchLatestNews(for: categoriesStorage.categories)
    }
}

extension CategoriesViewController {
    private func configureView(isFirstEnter: Bool) {
        if isFirstEnter {
            categoryView.headerTitle.text = constants
                .onboardingHeaderTitle
            categoryView.subtitle.text = constants
                .onboardingSubtitle
            categoryView.nextButton.addTarget(
                nil,
                action: #selector(nextButtonTapped),
                for: .touchUpInside
            )
        } else {
            categoryView.headerTitle.text = constants.headerTitle
            categoryView.subtitle.text = constants.subtitle
            categoryView.nextButton.removeFromSuperview()
        }
    }
}
