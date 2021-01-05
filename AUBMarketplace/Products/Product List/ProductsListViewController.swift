//
//  ProductsListViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/2/21.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    enum ListType {
        case category
        case query
    }
    
    let listType: ListType
    var inputString: String
    
    var products: [Product] = []
    
    enum Section: CaseIterable {
        case main
    }
    
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource
        <Section, Product>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot
        <Section, Product>! = nil
    static let titleElementKind = "title-element-kind"
    
    init(category: String) {
        self.inputString = category
        self.listType = .category
        super.init(nibName: nil, bundle: nil)
    }
    
    init(query: String) {
        self.inputString = query
        self.listType = .query
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureViews()
        configureConstraints()
        configureDataSource()
        configureDelegate()
        fetchProducts()
    }
    
}

//MARK: - View Setup
extension ProductsListViewController {
    private func configureNavBar() {
        if listType == .category {
            navigationItem.title = inputString
            navigationController?.navigationBar.prefersLargeTitles = true
        }
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
extension ProductsListViewController {
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
            
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
}


//MARK: - Data Source Setup
extension ProductsListViewController {
    
    private func reloadData() {
        currentSnapshot = NSDiffableDataSourceSnapshot
            <Section, Product>()
        
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(products)
        
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
    private func configureDataSource() {
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        
        dataSource = UICollectionViewDiffableDataSource<Section, Product>(collectionView: collectionView) { collectionView, indexPath, product in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell else {
                    fatalError("Unable to dequeue \(ProductCell.self)")
                }

                cell.configure(with: product)
                return cell
        }
        
        
        
        reloadData()
    }
    
}

//MARK: - Networking Setup
extension ProductsListViewController {
    
    public func fetchProducts() {
        if listType == .category {
            ProductManager.shared.fetchProductCategory(category: inputString, completion: didFetchProducts(products:))
        } else if listType == .query && inputString != "" {
            ProductManager.shared.fetchProductQuery(query: inputString, completion: didFetchProducts(products:))
        }
    }
    
    private func didFetchProducts(products: [Product]) {
        self.products = products
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
}

//MARK: - Colletion View Delegate Setup
extension ProductsListViewController: UICollectionViewDelegate {
    private func configureDelegate() {
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = dataSource.itemIdentifier(for: indexPath)!
        let detailVC = ProductDetailViewController()
        detailVC.product = product
        show(detailVC, sender: self)
    }
}
