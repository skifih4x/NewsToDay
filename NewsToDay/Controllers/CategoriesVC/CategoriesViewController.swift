//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import UIKit

final class CategoriesViewController: UIViewController {
    private var collectionView: UICollectionView?

    private let constants = CategoryConstants()
    private let categoriesStorage = CategoriesStorage.shared
    private let categories = Category.categories

    private let headerTitle: UILabel = {
        let label = UILabel()

        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 0.2, green: 0.212, blue: 0.278, alpha: 1)
        label.numberOfLines = 2

        return label
    }()

    private let subtitle: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.488, green: 0.51, blue: 0.632, alpha: 1)
        label.numberOfLines = 2

        return label
    }()

    private lazy var nextButton: UIButton? = {
        let button = UIButton()

        button.addTarget(nil, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.278, green: 0.353, blue: 0.842, alpha: 1)
        button.setTitle(constants.nextButtonTitle, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12

        return button
    }()

    private lazy var categoriesTitle = getCategories()

    init(isFirstEnter: Bool) {
        super.init(nibName: nil, bundle: nil)
        if isFirstEnter {
            headerTitle.text = constants.onboardingHeaderTitle
            subtitle.text = constants.onboardingSubtitle
        } else {
            headerTitle.text = constants.headerTitle
            subtitle.text = constants.subtitle
            nextButton = nil
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeView()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(
            ButtonCell.self,
            forCellWithReuseIdentifier: "ButtonCell"
        )
        view.backgroundColor = .white
    }

    @objc
    private func nextButtonTapped() {
        dismiss(animated: true)
    }
}

extension CategoriesViewController {
    private func makeView() {
        let layout = getLayout()

        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView?.allowsMultipleSelection = true
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        view.addSubview(headerTitle)
        view.addSubview(subtitle)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 11
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -11
            ),
            collectionView.topAnchor.constraint(
                equalTo: subtitle.bottomAnchor,
                constant: 50
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -230
            ),
            headerTitle.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 30
            ),
            headerTitle.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            subtitle.topAnchor.constraint(
                equalTo: headerTitle.bottomAnchor,
                constant: 8
            ),
            subtitle.leadingAnchor.constraint(
                equalTo: headerTitle.leadingAnchor
            ),
            subtitle.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            )
        ])

        if let nextButton = nextButton {
            view.addSubview(nextButton)

            nextButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                nextButton.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -20
                ),
                nextButton.topAnchor.constraint(
                    equalTo: collectionView.bottomAnchor,
                    constant: 50
                ),
                nextButton.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 20
                ),
                nextButton.heightAnchor.constraint(
                    equalToConstant: 56
                )
            ])
        }

    }

    private func getLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalWidth(0.27)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 8, bottom: 8, trailing: 8
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.27)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item, count: 2
        )

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(
            section: section
        )
        return layout
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
        cell.set(title: categoriesTitle[indexPath.row])

        let itemDidSelected = categoriesStorage.categories.first { $0 == categories[indexPath.row] }

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
    }
}

extension CategoriesViewController {
    private func getCategories() -> [String] {
        let logos = ["💵", "🎨", "🌐", "💊", "🧬", "⚽", "📱"]
        let categories = Category.categories.map { $0.capitalized }

        return zip(logos, categories).map { $0.0 + " " + $0.1 }
    }
}
