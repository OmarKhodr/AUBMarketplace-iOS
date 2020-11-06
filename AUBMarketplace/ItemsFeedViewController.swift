//
//  ViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 10/22/20.
//

import UIKit

class ItemsFeedViewController: UIViewController {
    
    let itemController = ItemController()
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource
        <ItemController.ItemCollection, ItemController.Item>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot
        <ItemController.ItemCollection, ItemController.Item>! = nil
    static let titleElementKind = "title-element-kind"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        containView.backgroundColor = UIColor(named: "lightBlue")
        containView.layer.cornerRadius = 20
        containView.layer.masksToBounds = true
        let imageView = UIImageView(frame: CGRect(x: 0, y: 5, width: 40, height: 40))
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        containView.addSubview(imageView)
//        NSLayoutConstraint.activate([
//            imageView.centerXAnchor.constraint(equalTo: containView.centerXAnchor),
//            imageView.centerYAnchor.constraint(equalTo: containView.centerYAnchor)
//        ])
        let rightBarButton = UIBarButtonItem(customView: containView)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        configureHierarchy()
        configureDataSource()
    }
    
}

extension ItemsFeedViewController {
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int,
                                 layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // if we have the space, adapt and go 2-up+peeking 3rd item
            let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ? 0.425 : 0.85)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth),
                                                   heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(44))
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: titleSize,
                elementKind: ItemsFeedViewController.titleElementKind,
                alignment: .top)
            section.boundarySupplementaryItems = [titleSupplementary]
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider,
            configuration: config)
        return layout
    }
}


extension ItemsFeedViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration
        <ItemCell, ItemController.Item> { (cell, indexPath, item) in
            // Populate the cell with our item description.
            cell.titleLabel.text = item.title
            cell.categoryLabel.text = item.category
        }
        
        dataSource = UICollectionViewDiffableDataSource
        <ItemController.ItemCollection, ItemController.Item>(collectionView: collectionView, cellProvider: {
            (collectionView: UICollectionView, indexPath: IndexPath, item: ItemController.Item) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "Footer") {
            (supplementaryView, string, indexPath) in
            // Populate the view with our section's description.
            if let snapshot = self.currentSnapshot {
                // Populate the view with our section's description.
                let itemCategory = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = itemCategory.title
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
        
        currentSnapshot = NSDiffableDataSourceSnapshot
            <ItemController.ItemCollection, ItemController.Item>()
        
        itemController.collections.forEach {
            let collection = $0
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.items)
        }
        
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}
