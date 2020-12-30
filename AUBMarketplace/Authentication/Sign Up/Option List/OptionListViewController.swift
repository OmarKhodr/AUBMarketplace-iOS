//
//  OptionListViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/30/20.
//

import UIKit

class OptionListViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let options: [String]
    
    init(options: [String]) {
        self.options = options
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
