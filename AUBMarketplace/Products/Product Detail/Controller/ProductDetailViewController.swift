//
//  ProductDetailViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/17/20.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var scrollView: UIScrollView! = nil
    var contentView: UIView! = nil // Content view containing all views to layout in scroll view
    var largeView: ProductLargeView! = nil
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
        contentView = UIView()
        largeView = ProductLargeView(with: product)
        descriptionView = ProductDescriptionView(with: product)
    }
    
    private func setupConstraints() {
        
        // Add subviews to content view
        contentView.addSubview(largeView)
        largeView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionView)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add separator
        let separator = UIView()
        separator.backgroundColor = .quaternaryLabel
        contentView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false

        // Define constraints of subviews within content view
        NSLayoutConstraint.activate([
            largeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            largeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            largeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.topAnchor.constraint(equalTo: largeView.bottomAnchor, constant: 30),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 30),
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        /*
         UIScrollView layout using content layout guide and frame layout guide:
         . Content layout guide determines scrolling area of scroll view
         . Frame layout guide determines visible area of scroll view
         so layout as follows:
         1. Pin edges of main (content) view to content layout guide
         2. Pin frame layout guide to view controller's view
         */

        // Add content view to scroll view and pin to the scroll view's content layout guide
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // 1. Pin edges of main (content) view to content layout guide
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
        ])

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        // 2. Pin frame layout guide to view controller's view
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.frameLayoutGuide.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}
