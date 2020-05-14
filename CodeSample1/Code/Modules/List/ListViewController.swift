//
//  ListViewController.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

fileprivate let cellIdentifier = ListTableCell.description()

class ListViewController: UIViewController, ListViewProtocol, UITableViewDelegate, UITableViewDataSource {
    var interactor: ListInteractorProtocol!
    
    var tableView: UITableView!
    var array: [ListItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupData()
        setupBar()
        
        tableView.reloadData()
    }
    
    fileprivate func setupTable() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.register(ListTableCell.self, forCellReuseIdentifier: cellIdentifier)
        
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
            let item = ListItemModel()
            item.name = "item #\(i)"
            item.selected = i % 2 == 0
            array.append(item)
        }
    }
    
    fileprivate func setupBar() {
        self.navigationItem.title = ui.string.common.list
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: ui.string.common.add, style: .plain, target: self, action: #selector(addButtonTouched))
    }
    
    // MARK: Actions
    
    @objc func addButtonTouched() {
        interactor.addButtonTouched()
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
        if let listCell = cell as? ListTableCell {
            let item = array[indexPath.row]
            listCell.update(model: item)
        }
        return cell
    }
}
