//
//  AddProductViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/3/21.
//

import UIKit

class AddProductViewController: UIViewController {
    
    let scrollView = UIScrollView()
    var addProductView: AddProductView!
    
    var selectedCurrencyIndex: Int? = nil
    var selectedCategoryIndex: Int? = nil
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        setupNavItem()
        setupSubviews()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addProductView.titleTextField.becomeFirstResponder()
    }

}


//MARK: - Subviews
extension AddProductViewController {
    private func setupNavItem() {
        navigationItem.title = "New Product"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        // Right bar button item
        let postButton = UIBarButtonItem(title: "Post Product", style: .done, target: self, action: #selector(didTapPost))
        postButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = postButton
        // Left bar button item
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        doneButton.tintColor = .systemGreen
        navigationItem.leftBarButtonItem = doneButton
    }
    
    private func setupSubviews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addProductView = AddProductView(currencyAction: didTapCurrency, categoryAction: didTapCategory)
        addProductView.translatesAutoresizingMaskIntoConstraints = false
        
        addProductView.titleTextField.delegate = self
        addProductView.priceTextField.delegate = self
    }
}


//MARK: - Constraints
extension AddProductViewController {
    private func setupConstraints() {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(addProductView)
        
        NSLayoutConstraint.activate([
            addProductView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            addProductView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addProductView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            addProductView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor)
        ])
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        scrollView.frameLayoutGuide.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }
}


//MARK: - Actions
extension AddProductViewController {
    @objc private func didTapDone() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapPost() {
        if let name = addProductView.titleTextField.text,
            let price = Int(addProductView.priceTextField.text ?? "NO"),
            let category = addProductView.categoryListButton.chosenOptionLabel.text {
            
            let newProduct: [String: Any] = [
                "name": name,
                "category": category,
                "description": "Here goes the description.",
                "majors": [String](),
                "price": price
                
            ]
            ProductManager.shared.postProduct(newProduct, completion: didPostProduct)
            
        }
        
    }
    
    private func didPostProduct() {
        print("Post Successful!")
        dismiss(animated: true, completion: nil)
    }
    
    private func didTapCurrency() {
        let options = ["USD", "LBP"]
        let optionsVC = OptionListViewController(options: options, selectedRow: selectedCurrencyIndex, callBack: backFromCurrencyOptions)
        show(optionsVC, sender: self)
    }
    
    private func backFromCurrencyOptions(selectedCurrency: String?, selectedIndex: Int?) {
        selectedCurrencyIndex = selectedIndex
        addProductView.currencyListButton.chosenOptionLabel.text = selectedCurrency == nil ? "None" : selectedCurrency
    }
    
    private func didTapCategory() {
        let options = [
            "Book",
            "Notes",
            "Supplies",
            "Electronics",
            "Other"
        ]
        let optionsVC = OptionListViewController(options: options, selectedRow: selectedCategoryIndex, callBack: backFromCategoryOptions)
        show(optionsVC, sender: self)
    }
    
    private func backFromCategoryOptions(selectedCategory: String?, selectedIndex: Int?) {
        selectedCategoryIndex = selectedIndex
        addProductView.categoryListButton.chosenOptionLabel.text = selectedCategoryIndex == nil ? "None" : selectedCategory
    }
}


//MARK: - UITextField Delegate
extension AddProductViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
