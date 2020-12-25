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
    
    var titleVC: ServiceDetailTitleViewController!
    
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
        setupChildrenViewControllers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension ServiceDetailViewController {
    private func setupChildrenViewControllers() {
        titleVC = ServiceDetailTitleViewController(service: service)
        titleVC.view.translatesAutoresizingMaskIntoConstraints = false
        add(titleVC)
        
        NSLayoutConstraint.activate([
            titleVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}
