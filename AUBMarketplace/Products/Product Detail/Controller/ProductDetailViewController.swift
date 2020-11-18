//
//  ProductDetailViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/17/20.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    enum ProductDetailSection: Int {
        case large = 0
        case description = 1
    }
    
    var scrollView: UIScrollView! = nil
    var mainView: UIView! = nil
    var largeView: LargeProductView! = nil
    var descriptionView: ProductDescriptionView! = nil
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
    }
    
}

extension ProductDetailViewController {
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        scrollView = UIScrollView()
        mainView = UIView()
        largeView = LargeProductView(with: product)
        descriptionView = ProductDescriptionView(with: product)
    }
    
    private func setupConstraints() {

        mainView.addSubview(largeView)
        largeView.translatesAutoresizingMaskIntoConstraints = false

        mainView.addSubview(descriptionView)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        let separator = UIView()
        separator.backgroundColor = .quaternaryLabel
        mainView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            largeView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            largeView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            largeView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.topAnchor.constraint(equalTo: largeView.bottomAnchor, constant: 30),
            separator.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            
            descriptionView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 30),
            descriptionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            descriptionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -40),
            descriptionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20)
        ])

        print(mainView.bounds.height)

        scrollView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            mainView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
        ])

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        print(view.bounds.height)

        scrollView.frameLayoutGuide.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}
