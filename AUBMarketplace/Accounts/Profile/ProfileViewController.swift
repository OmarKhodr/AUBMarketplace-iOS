//
//  ProfileViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/6/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User? = nil
    
    let scrollView = UIScrollView()
    
    var infoView: ProfileInfoView!
    let myProductsButton = FilledButton(textColor: .label, backgroundColor: .systemGray6)
    let myServicesButton = FilledButton(textColor: .label, backgroundColor: .systemGray6)
    
    override func loadView() {
        super.loadView()
        setupNavItem()
        setupSubviews()
        setupConstraints()
        setupActions()
        fetchUser()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


//MARK: - Navigation Item
extension ProfileViewController {
    private func setupNavItem() {
        navigationItem.title = "My Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

//MARK: - Subviews
extension ProfileViewController {
    private func setupSubviews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        infoView = ProfileInfoView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        
        myProductsButton.setTitle("Posted Products", for: .normal)
        myServicesButton.setTitle("Posted Services", for: .normal)
    }
}

//MARK: - Constraints
extension ProfileViewController {
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [
            infoView,
            myProductsButton,
            myServicesButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
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
extension ProfileViewController {
    private func setupActions() {
        myProductsButton.addTarget(self, action: #selector(didTapProductsButton), for: .touchUpInside)
        myServicesButton.addTarget(self, action: #selector(didTapServicesButton), for: .touchUpInside)
    }
    
    @objc private func didTapProductsButton() {
        
    }
    
    @objc private func didTapServicesButton() {
        
    }
}


//MARK: - Networking
extension ProfileViewController {
    private func fetchUser() {
        UserManager.shared.fetchCurrentUser(completion: didFetchCurrentUser(user:))
    }
    
    private func didFetchCurrentUser(user: User) {
        self.user = user
        self.infoView.configureData(with: user)
    }
}
