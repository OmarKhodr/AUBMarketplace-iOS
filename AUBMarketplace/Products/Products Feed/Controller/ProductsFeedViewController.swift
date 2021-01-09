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
    
    let reloadDataLock = NSLock()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureViews()
        configureConstraints()
        configureDataSource()
        configureDelegate()
        configureRefreshControl()
        fetchProducts()
    }
    
}


//MARK: - View Setup
extension ProductsFeedViewController {
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Products Feed"
        
        // Right bar button items
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        addButton.tintColor = .systemGreen
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        searchButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItems = [addButton, searchButton]
    }
    
    @objc private func addTapped() {
        let addVC = AddProductViewController()
        present(UINavigationController(rootViewController: addVC), animated: true, completion: nil)
    }
    
    @objc private func searchTapped() {
        let searchVC = SearchViewController(type: .products)
        present(UINavigationController(rootViewController: searchVC), animated: true, completion: nil)
    }
    
    private func configureViews() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        
        collectionView.delaysContentTouches = false
        
        for case let scrollView as UIScrollView in collectionView.subviews {
            scrollView.delaysContentTouches = false
        }
    }
    
    private func configureConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.fillSuperview()
    }
}


//MARK: - Collection View Compositional Layout
extension ProductsFeedViewController {
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let collection = self.productController.collections[sectionIndex]
            
            switch collection.sectionType {
            case .categories:
                return self.createSmallTableSection()
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
    
    private func createSmallTableSection() -> NSCollectionLayoutSection {
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
        
        dataSource.apply(currentSnapshot, animatingDifferences: true)
        
        stopRefreshControl()
    }
    
    private func configureDataSource() {
        registerCells()
        
        dataSource = UICollectionViewDiffableDataSource<ProductCollection, Product>(collectionView: collectionView) { collectionView, indexPath, product in
            
//            if (product.title == "Inde410 book") {
//                print("Here: \(indexPath.section) \(indexPath.row)")
//            }
            
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
    
}


//MARK: - Networking Setup
extension ProductsFeedViewController {
    
    private func fetchProducts() {
        ProductManager.shared.fetchFeedProducts(section: .foryou, completion: insertFetchedProducts(_:section:))
        ProductManager.shared.fetchFeedProducts(section: .hottest, completion: insertFetchedProducts(_:section:))
        ProductManager.shared.fetchFeedProducts(section: .recent, completion: insertFetchedProducts(_:section:))
    }

    private func insertFetchedProducts(_ products: [Product], section: ProductSection) {
        
        let ind = section.rawValue
        productController.collections[ind].products = products
        
        DispatchQueue.main.async {
            self.reloadData()
        }
        
    }
    
}


//MARK: - Colletion View Delegate Setup
extension ProductsFeedViewController: UICollectionViewDelegate {
    private func configureDelegate() {
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = dataSource.itemIdentifier(for: indexPath)!
        
        if product.isCategory {
            let categoryVC = ProductsListViewController(category: product.title)
            show(categoryVC, sender: self)
        } else {
            let detailVC = ProductDetailViewController()
            detailVC.product = product
            show(detailVC, sender: self)
        }
    }
}


//MARK: - Refresh Control
extension ProductsFeedViewController {
    func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        reloadData()
    }
    
    func stopRefreshControl() {
        DispatchQueue.main.async {
            if let refreshControl = self.collectionView.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
        }
    }
}
