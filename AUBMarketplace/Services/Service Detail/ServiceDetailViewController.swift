//
//  ServiceDetailViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/23/20.
//

import UIKit

class ServiceDetailViewController: UIViewController {
    
    let service: Service
    
    let scrollView = UIScrollView()
    var titleView: ServiceDetailTitleView!
    var descriptionView: ServiceDetailDescriptionView!
    
    init(service: Service) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
}

extension ServiceDetailViewController {
    private func setupSubviews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView = ServiceDetailTitleView(service: service, applyAction: applyAction)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionView = ServiceDetailDescriptionView(service: service)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Constraint Setup
extension ServiceDetailViewController {
    private func setupConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [
            titleView,
            descriptionView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
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

//MARK: - Action Setup
extension ServiceDetailViewController {
    private func applyAction() {
        print("Tapped Apply!")
    }
}
