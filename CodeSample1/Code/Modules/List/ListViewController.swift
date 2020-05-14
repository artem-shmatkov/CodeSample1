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
        setupBar()
        
        interactor.viewReady()
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
    
    fileprivate func setupBar() {
        self.navigationItem.title = ui.string.common.list
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: ui.string.common.add, style: .plain, target: self, action: #selector(addButtonTouched))
    }
    
    // MARK: ListViewProtocol
    
    func update(array: [ListItemModel]) {
        self.array = array
        tableView.reloadData()
    }
    
    func update(element: ListItemModel) {
        array.append(element)
        tableView.reloadData()
    }
    
    // MARK: Actions
    
    @objc func addButtonTouched() {
        interactor.addButtonTouched()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let element = array[indexPath.row]
            interactor.deleteElement(id: element.id)
            
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .normal, title: ui.string.common.edit, handler: { [weak self] action, view, success in
            if let sself = self {
                let element = sself.array[indexPath.row]
                sself.interactor.editElement(id: element.id)
                success(true)
            } else {
                success(false)
            }
        })
        closeAction.backgroundColor = UIColor.green.withAlphaComponent(0.75)
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = array[indexPath.row]
        interactor.editElement(id: element.id)
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
