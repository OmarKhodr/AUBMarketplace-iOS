//
//  SearchViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/4/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    enum SearchType {
        case products
        case services
    }
    
    let searchType: SearchType
    
    let searchBar = UISearchBar()
    let resultsVC: UIViewController
    
    init(type: SearchType) {
        self.searchType = type
        if (type == .products) {
            resultsVC = ProductsListViewController(query: "")
        } else {
            resultsVC = ServicesListViewController()
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItem()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK: - Subviews
extension SearchViewController {
    private func setupNavItem() {
        navigationItem.title = "Search"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        doneButton.tintColor = .systemGreen
        
        navigationItem.leftBarButtonItem = doneButton
    }
    
    @objc private func didTapDone() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupSubviews() {
        view.backgroundColor = .systemBackground
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Products"
        searchBar.autocapitalizationType = .none
        searchBar.delegate = self
        
        resultsVC.view.translatesAutoresizingMaskIntoConstraints = false
        
    }
}

//MARK: - Constraints
extension SearchViewController {
    private func setupConstraints() {
        view.addSubview(searchBar)
        add(resultsVC)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            resultsVC.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            resultsVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            resultsVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            resultsVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

//MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide keyboard
        searchBar.resignFirstResponder()
        
        guard let query = searchBar.text else { return }
        
        if searchType == .products {
            let productsListVC = resultsVC as! ProductsListViewController
            productsListVC.inputString = query
            productsListVC.fetchProducts()
        } else {
            // TODO
        }
    }
}
