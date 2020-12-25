//
//  ServicesFeedViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/22/20.
//

import UIKit

class ServicesFeedViewController: UIViewController {
    
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    
    var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    override func loadView() {
        super.loadView()
        setupViews()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.title = "Services"
    }

}

extension ServicesFeedViewController {
    
    private func setupViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ServiceCell.self, forCellReuseIdentifier: ServiceCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension ServicesFeedViewController {
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
}

extension ServicesFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.reuseIdentifier, for: indexPath) as! ServiceCell
        cell.configure(with: Service())
        return cell
    }
    
    
}

extension ServicesFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedService = Service() // production: let service = services[indexPath.row]
        let detailVC = ServiceDetailViewController(service: selectedService)
        show(detailVC, sender: self)
    }
}
