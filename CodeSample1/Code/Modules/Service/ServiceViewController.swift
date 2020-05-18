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
    var array: [ServiceItemModel] = []
    
    var errorView: ErrorView!
    var loaderView: LoaderView!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTable()
        setupBar()
        
        setupLoaderView()
        setupErrorView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLoading(true)
        interactor.viewReady()
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
    
    fileprivate func setupBar() {
        self.navigationItem.title = ui.string.common.service
    }
    
    fileprivate func setupLoaderView() {
        loaderView = LoaderView()
        view.addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loaderView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loaderView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loaderView.isHidden = true
        loaderView.setup()
    }
    
    fileprivate func setupErrorView() {
        errorView = ErrorView()
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        errorView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        errorView.isHidden = true
        errorView.setup()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideError))
        errorView.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func showLoading(_ loading: Bool) {
        loaderView.isHidden = false
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction, .allowAnimatedContent, .curveEaseInOut], animations: { [weak self] in
            self?.loaderView.alpha = loading ? 1.0 : 0.0
            self?.tableView.alpha = loading ? 0.0 : 1.0
        }) { [weak self] (finished) in
            self?.loaderView.alpha = loading ? 1.0 : 0.0
            self?.tableView.alpha = loading ? 0.0 : 1.0
        }
    }
    
    @objc fileprivate func hideError() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction, .allowAnimatedContent, .curveEaseInOut], animations: { [weak self] in
            self?.errorView.alpha = 0.0
        }) { [weak self] (finished) in
            self?.errorView.alpha = 0.0
            self?.errorView.isHidden = true
        }
    }
    
    // MARK: ServiceViewProtocol
    
    func showList(_ list: [ServiceItemModel]) {
        array = list
        tableView.reloadData()
        showLoading(false)
    }
    
    func showError(_ error: Error?) {
        errorView.alpha = 0.0
        errorView.isHidden = false
        
        errorView.update(error)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction, .allowAnimatedContent, .curveEaseInOut], animations: { [weak self] in
            self?.errorView.alpha = 1.0
        }) { [weak self] (finished) in
            self?.errorView.alpha = 1.0
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
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
