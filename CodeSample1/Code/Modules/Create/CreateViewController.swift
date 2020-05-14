//
//  CreateViewController.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class CreateViewController: UIViewController, CreateViewProtocol, UITextFieldDelegate {
    var interactor: CreateInteractorProtocol!
    
    fileprivate var titleLabel: UILabel!
    fileprivate var textField: TextField!
    
    fileprivate var doneButton: UIButton!
    fileprivate var revertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupBar()
        setupTextfield()
        setupButtons()
        setupTitle()
        setupLayout()
        
        interactor.viewReady()
    }
    
    fileprivate func setupBar() {
        self.navigationItem.title = ui.string.common.add
        
        let barButton = UIBarButtonItem(title: ui.string.common.back, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    fileprivate func setupTitle() {
        titleLabel = UILabel()
        titleLabel.text = ui.string.common.itemName
        view.addSubview(titleLabel)
    }
    
    fileprivate func setupTextfield() {
        textField = TextField()
        textField.padding = UIEdgeInsets(top: 4, left: 20, bottom: 2, right: 20)
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.delegate = self
        view.addSubview(textField)
        textField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
    }
    
    fileprivate func setupButtons() {
        doneButton = UIButton(type: .system)
        doneButton.setTitle(ui.string.common.done, for: [])
        
        revertButton = UIButton(type: .system)
        revertButton.setTitle(ui.string.common.revert, for: [])
        
        doneButton.setTitleColor(.white, for: [])
        revertButton.setTitleColor(.white, for: [])
        
        view.addSubview(doneButton)
        view.addSubview(revertButton)
        
        doneButton.backgroundColor = .blue
        revertButton.backgroundColor = .red
        
        doneButton.layer.cornerRadius = 10
        revertButton.layer.cornerRadius = 10
        
        doneButton.addTarget(self, action: #selector(doneButtonTouched), for: .touchUpInside)
        revertButton.addTarget(self, action: #selector(revertButtonTouched), for: .touchUpInside)
        
        doneButton.isEnabled = false
        doneButton.alpha = 0.5
    }
    
    fileprivate func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50).isActive = true
        doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        revertButton.translatesAutoresizingMaskIntoConstraints = false
        revertButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50).isActive = true
        revertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        revertButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        revertButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    fileprivate func showAlert() {
        let alert = UIAlertController(title: ui.string.common.warning, message: ui.string.common.saveChanges, preferredStyle: .alert)
        let actionNo = UIAlertAction(title: ui.string.common.no, style: .destructive) { [weak self] (action) in
            self?.interactor.discard()
        }
        
        let actionYes = UIAlertAction(title: ui.string.common.yes, style: .default) { [weak self] (action) in
            if let sself = self, let text = sself.textField.text {
                sself.interactor.apply(string: text)
            }
        }
        
        alert.addAction(actionNo)
        alert.addAction(actionYes)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: CreateViewProtocol
    
    func update(item: ListItemModel) {
        textField.text = item.name
    }
    
    // MARK: Actions
    
    @objc fileprivate func doneButtonTouched() {
        if let text = textField.text {
            interactor.apply(string: text)
        }
    }

    @objc fileprivate func revertButtonTouched() {
        interactor.discard()
    }
    
    @objc fileprivate func backButtonTouched() {
        if let text = textField.text, text != "" {
            showAlert()
        } else {
            interactor.discard()
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        doneButton.isEnabled = string != ""
        doneButton.alpha = string != "" ? 1.0 : 0.5
        return true
    }
}
