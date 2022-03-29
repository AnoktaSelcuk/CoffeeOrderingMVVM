//
//  OrdersTableViewControllers.swift
//  CoffeeOrderingMVVM
//
//  Created by Alperen Selçuk on 26.03.2022.
//  Copyright © 2022 Alperen Selçuk. All rights reserved.
//

import UIKit

class OrdersTableViewControllers: UITableViewController {

    //property
    var orderListViewModel = OrderListViewModel()
    
    
    //view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleRightBarButton))
        self.tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: "order-cell-reuse-identifier")
        
        
        populateOrders()
    }

    @objc func handleRightBarButton() {
        navigationController?.pushViewController(AddOrderViewControllers(), animated: true)
    }
    

    fileprivate func populateOrders() {
        
        WebService().load(resource: Order.all) { [unowned self] (result) in
            
            switch result {
            case .success(let orders):
                self.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.orderListViewModel.ordersViewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "order-cell-reuse-identifier", for: indexPath) as! OrderTableViewCell
        
        cell.productNameTextLabel.text = vm.type
        cell.sizeTextLabel.text = vm.size
        
        return cell
    }
}
