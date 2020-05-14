//
//  ServiceViewController.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

fileprivate let cellIdentifier = ServiceTableCell.description()

class ServiceViewController: UIViewController, ServiceViewProtocol, UITableViewDelegate, UITableViewDataSource {
    var interactor: ServiceInteractorProtocol!
    
    var tableView: UITableView!
    var array: [ServiceItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupData()
        tableView.reloadData()
    }
    
    fileprivate func setupTable() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.register(ServiceTableCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    fileprivate func setupData() {
        for i in 0...9 {
            let item = ServiceItemModel()
            item.title = "item #\(i)"
            array.append(item)
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let listCell = cell as? ServiceTableCell {
            let item = array[indexPath.row]
            listCell.update(model: item)
        }
        return cell
    }
}
