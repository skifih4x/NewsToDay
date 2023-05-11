//
//  CategoriesView.swift
//  NewsToDay
//
//  Created by Ramil Yanberdin on 11.05.2023.
//

import UIKit

final class CategoriesView: UIView {
    var collectionView: UICollectionView?

    private let constants = CategoryConstants()

    let headerTitle: UILabel = {
        let label = UILabel()

        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = UIColor(
            red: 0.2, green: 0.212, blue: 0.278, alpha: 1
        )
        label.numberOfLines = 2

        return label
    }()

    let subtitle: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(
            red: 0.488, green: 0.51, blue: 0.632, alpha: 1
        )
        label.numberOfLines = 2

        return label
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = UIColor(
            red: 0.278, green: 0.353, blue: 0.842, alpha: 1
        )
        button.setTitle(constants.nextButtonTitle, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension CategoriesView {
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
        addSubview(collectionView)
        addSubview(headerTitle)
        addSubview(subtitle)
        addSubview(nextButton)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 11
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -11
            ),
            collectionView.topAnchor.constraint(
                equalTo: subtitle.bottomAnchor,
                constant: 50
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -230
            ),
            headerTitle.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 30
            ),
            headerTitle.leadingAnchor.constraint(
                equalTo: leadingAnchor,
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
                equalTo: trailingAnchor,
                constant: -20
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20
            ),
            nextButton.topAnchor.constraint(
                equalTo: collectionView.bottomAnchor,
                constant: 50
            ),
            nextButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 20
            ),
            nextButton.heightAnchor.constraint(
                equalToConstant: 56
            )
        ])
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

extension CategoriesView {
    func getCategories() -> [String] {
        let logos = ["💵", "🎨", "🌐", "💊", "🧬", "⚽", "📱"]
        let categories = Category.categories.map { $0.capitalized }

        return zip(logos, categories).map { $0.0 + " " + $0.1 }
    }
}
