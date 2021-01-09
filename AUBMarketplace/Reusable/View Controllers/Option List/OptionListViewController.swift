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
    
    var selectedRow: Int? = nil
    
    let callBack: ((String?, Int?) -> Void)
    
    init(options: [String], selectedRow: Int?, callBack: @escaping(String?, Int?) -> Void) {
        self.options = options
        self.selectedRow = selectedRow
        self.callBack = callBack
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        setupSubviews()
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let selectedOption = selectedRow == nil ? nil : options[selectedRow!]
        callBack(selectedOption, selectedRow)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Subviews
extension OptionListViewController {
    private func setupSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "optionCell")
        tableView.delegate = self
    }
}

//MARK: - Constraints
extension OptionListViewController {
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
}

//MARK: - Data Source
extension OptionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        cell.textLabel!.text = options[indexPath.row]
        if let selectedRow = selectedRow, selectedRow == indexPath.row {
            cell.accessoryType = .checkmark
        }
        return cell
    }
}

//MARK: - Delegate
extension OptionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected!")
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        // Deselect previous row if different from selected row
        if let selectedRow = selectedRow, selectedRow != indexPath.row {
            let prevCell = tableView.cellForRow(at: IndexPath(row: selectedRow, section: 0))
            prevCell?.accessoryType = .none
        }
        
        selectedRow = indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
