//
//  AddOrderViewControllers.swift
//  CoffeeOrderingMVVM
//
//  Created by Alperen Selçuk on 26.03.2022.
//  Copyright © 2022 Alperen Selçuk. All rights reserved.
//

import UIKit

protocol AddCoffeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController)
}

class AddOrderViewControllers: UIViewController {

    var delegate: AddCoffeOrderDelegate?
    private var vm = AddOrderViewModel()
    private var cupSizeSegmentedControl: UISegmentedControl!
    private let overallStack = UIStackView()
    
    let productTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        return tv
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "name"
        tf.backgroundColor = .systemGray5
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 10
        
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "surname"
        tf.backgroundColor = .systemGray5
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 10
        
        return tf
    }()
        
    //View lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}


extension AddOrderViewControllers {
    fileprivate func setup() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneButton))
        
        self.cupSizeSegmentedControl = UISegmentedControl(items: self.vm.sizes)

        [productTableView, nameTextField, emailTextField, cupSizeSegmentedControl].forEach { overallStack.addArrangedSubview($0) }
        
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(AddOrderTableViewCell.self, forCellReuseIdentifier: "AddOrder-cell-reuse-identifier")
    }
    
    fileprivate func layout() {
        
        overallStack.axis = .vertical
        overallStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(overallStack)
        
        overallStack.setCustomSpacing(30, after: productTableView)
        overallStack.setCustomSpacing(8, after: nameTextField)
        overallStack.setCustomSpacing(30, after: emailTextField)
        
        NSLayoutConstraint.activate([
            overallStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            overallStack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            overallStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
}

//UITableView delegate
extension AddOrderViewControllers: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddOrder-cell-reuse-identifier") as! AddOrderTableViewCell
        cell.textLabel1.text = self.vm.types[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

//@objc func
extension AddOrderViewControllers {
    @objc fileprivate func handleDoneButton() {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.cupSizeSegmentedControl.titleForSegment(at: self.cupSizeSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = self.productTableView.indexPathForSelectedRow else { fatalError("Error in selecting coffee") }
        
        self.vm.name = name
        self.vm.email = email
        
        self.vm.selectedSize = selectedSize
        self.vm.selectedType = self.vm.types[indexPath.row]
        
        WebService().load(resource: Order.create(vm: self.vm)) { (result) in
            switch result {
            case .success(let order):
                
                if let order = order, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
                    }
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}

