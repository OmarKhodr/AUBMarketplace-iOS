//
//  ServicesListViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/22/20.
//

import UIKit

class ServicesListViewController: UIViewController {
    
    let tableView = UITableView()
    
    var services: [Service] = []
    
    override func loadView() {
        super.loadView()
        setupViews()
        setupConstraints()
        fetchServices()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.deselectedRow(withCoordinator: self.transitionCoordinator)
    }

}


//MARK: - Navigation Item Seutp
extension ServicesListViewController {
    private func setupNavItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Services Feed"
        
        // Right bar button items
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        addButton.tintColor = .systemGreen
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        searchButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItems = [addButton, searchButton]
    }
    
    @objc private func addTapped() {
        
    }
    
    @objc private func searchTapped() {
        
    }
}


//MARK: - Subviews Setup
extension ServicesListViewController {
    
    private func setupViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ServiceCell.self, forCellReuseIdentifier: ServiceCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
}


//MARK: - Constraints Setup
extension ServicesListViewController {
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
}


//MARK: - Data Source Setup
extension ServicesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.reuseIdentifier, for: indexPath) as! ServiceCell
        cell.configure(with: services[indexPath.row])
        return cell
    }
    
    
}


//MARK: - Delegate Setup
extension ServicesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedService = services[indexPath.row]
        let detailVC = ServiceDetailViewController(service: selectedService)
        show(detailVC, sender: self)
    }
}


//MARK: - Networking Setup
extension ServicesListViewController {
    private func fetchServices() {
        ServiceManager.shared.fetchFeedServices(completion: didFetchServices(services:))
    }
    
    private func didFetchServices(services: [Service]) {
        self.services = services
        tableView.reloadData()
    }
}
