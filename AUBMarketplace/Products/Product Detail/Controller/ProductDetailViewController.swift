//
//  ProductDetailViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/17/20.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    let product: Product
    
    var scrollView: UIScrollView!
    var contentView: UIView!// Content view containing all views to layout in scroll view
    var imagesVC: ProductImagesViewController!
    var titleView: ProductDetailTitleView!
    var actionView: ProductDetailActionView!
    var descriptionView: ProductDescriptionView!
    
    init(with product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupViews()
        setupConstraints()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - Subviews + Constraints
extension ProductDetailViewController {
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        scrollView = UIScrollView()
        contentView = UIView()
        
        imagesVC = ProductImagesViewController(with: product)
        imagesVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        titleView = ProductDetailTitleView(with: product)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        actionView = ProductDetailActionView()
        actionView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionView = ProductDescriptionView(with: product)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        
        // Add subviews to content view
        addChild(imagesVC)
        contentView.addSubview(imagesVC.view)
        imagesVC.didMove(toParent: self)
        
        contentView.addSubview(titleView)
        contentView.addSubview(actionView)
        contentView.addSubview(descriptionView)
        
        // Add separator
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        contentView.addSubview(separator)
        
        let separator2 = UIView()
        separator2.translatesAutoresizingMaskIntoConstraints = false
        separator2.backgroundColor = .quaternaryLabel
        contentView.addSubview(separator2)
        
        // Define constraints of subviews within content view
        NSLayoutConstraint.activate([
            
            imagesVC.view.heightAnchor.constraint(equalToConstant: 250),
            imagesVC.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            imagesVC.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagesVC.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleView.topAnchor.constraint(equalTo: imagesVC.view.bottomAnchor, constant: 20),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            actionView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            actionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            actionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            separator2.heightAnchor.constraint(equalToConstant: 1),
            separator2.topAnchor.constraint(equalTo: actionView.bottomAnchor, constant: 20),
            separator2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separator2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionView.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 20),
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

//        scrollView.frameLayoutGuide.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}


//MARK: - Actions
extension ProductDetailViewController {
//    private func didTapBuy() {
//        let alert = UIAlertController(title: "Request Complete!", message: "Your are now the potential buyer for this product! You can contact the seller using their contact information on their profile page.", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: didTapOkay(sender:)))
//
//        self.present(alert, animated: true)
//    }
//
//    private func didTapOkay(sender: UIAlertAction) {
//        product.status = .saleInProgress
//        largeView.buyButton.setTitle("SALE IN PROGRESS", for: .disabled)
//        largeView.buyButton.isEnabled = false
//    }
}
