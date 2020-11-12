//
//  ViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 10/22/20.
//

import UIKit

class ProductsFeedViewController: UIViewController {
    
    let productController = ProductController()
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource
        <ProductCollection, Product>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot
        <ProductCollection, Product>! = nil
    static let titleElementKind = "title-element-kind"
    
    let productManager = ProductManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureHierarchy()
        configureDataSource()
        fetchProducts()
    }
    
}

//MARK: - View Setup
extension ProductsFeedViewController {
    private func configureNavBar() {
        navigationItem.title = "Products"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
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
}

//MARK: - Collection View Compositional Layout
extension ProductsFeedViewController {
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let collection = self.productController.collections[sectionIndex]
            
            switch collection.sectionType {
                case .categories:
                    return self.createSmallTableSection(layoutEnvironment: layoutEnvironment)
                default:
                    return self.createProductSection(layoutEnvironment: layoutEnvironment)
            }
            
            
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createProductSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // if we have the space, adapt and go 2-up+peeking 3rd item
        let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ? 0.425 : 0.93)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth),
                                               heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
        let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: titleSize,
            elementKind: ProductsFeedViewController.titleElementKind,
            alignment: .top)
        section.boundarySupplementaryItems = [titleSupplementary]
        return section
    }
    
    private func createSmallTableSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93),
                                               heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
        let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: titleSize,
            elementKind: ProductsFeedViewController.titleElementKind,
            alignment: .top)
        section.boundarySupplementaryItems = [titleSupplementary]
        return section
    }
    
}


//MARK: - Data Source Setup
extension ProductsFeedViewController {
    
    private func configure<T: SelfConfiguringProductCell>(_ cellType: T.Type, with product: Product, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }

        cell.configure(with: product)
        return cell
    }
    
    private func registerCells() {
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: ProductsFeedViewController.titleElementKind, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        collectionView.register(SmallTableCell.self, forCellWithReuseIdentifier: SmallTableCell.reuseIdentifier)
    }
    
    private func reloadData() {
        currentSnapshot = NSDiffableDataSourceSnapshot
            <ProductCollection, Product>()
        
        productController.collections.forEach {
            let collection = $0
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.products)
        }
        
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    
    private func configureDataSource() {
        registerCells()
        
        dataSource = UICollectionViewDiffableDataSource<ProductCollection, Product>(collectionView: collectionView) { collectionView, indexPath, product in
            switch self.productController.collections[indexPath.section].sectionType {
            case .categories:
                return self.configure(SmallTableCell.self, with: product, for: indexPath)
            default:
                return self.configure(ProductCell.self, with: product, for: indexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier, for: indexPath) as? TitleSupplementaryView else {
                return nil
            }

            // Populate the view with our section's description.
            if let snapshot = self?.currentSnapshot {
                // Populate the view with our section's description.
                let productCategory = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = productCategory.title
            }
            
            return supplementaryView
        }
        
        reloadData()
    }
    
    private func temp() {
        registerCells()
        
        let cellRegistration = UICollectionView.CellRegistration
        <ProductCell, Product> { (cell, indexPath, product) in
            // Populate the cell with our item description.
            cell.titleLabel.text = product.title
            cell.categoryLabel.text = product.category
        }
        
        dataSource = UICollectionViewDiffableDataSource
        <ProductCollection, Product>(collectionView: collectionView, cellProvider: {
            (collectionView: UICollectionView, indexPath: IndexPath, product: Product) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: product)
        })
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "Header") {
            (supplementaryView, string, indexPath) in
            // Populate the view with our section's description.
            if let snapshot = self.currentSnapshot {
                // Populate the view with our section's description.
                let productCategory = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = productCategory.title
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
        
        currentSnapshot = NSDiffableDataSourceSnapshot
            <ProductCollection, Product>()
        
        productController.collections.forEach {
            let collection = $0
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.products)
        }
        
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

extension ProductsFeedViewController: ProductManagerDelegate {
    
    private func fetchProducts() {
        productManager.delegate = self
        productManager.fetchRecommended()
        productManager.fetchHottest()
        productManager.fetchRecentlyViewed()
    }
    
    func didFailWithError(_ manager: ProductManager, error: Error) {
        print(error)
    }
    
    func didFetchRecommendedProducts(_ manager: ProductManager, products: [Product]) {
        productController.collections.insert(ProductCollection(title: "For You", sectionType: .foryou, products: products), at: 0)
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func didFetchHottestProducts(_ manager: ProductManager, products: [Product]) {
        productController.collections.insert(ProductCollection(title: "Hottest", sectionType: .hottest, products: products), at: 1)
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func didFetchRecentProducts(_ manager: ProductManager, products: [Product]) {
        productController.collections.append(ProductCollection(title: "Recently Viewed", sectionType: .recent, products: products))
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    
    
    
}
