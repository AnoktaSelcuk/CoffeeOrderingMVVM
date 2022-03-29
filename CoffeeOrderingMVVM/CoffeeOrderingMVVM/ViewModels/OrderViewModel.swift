//
//  OrderViewModel.swift
//  CoffeeOrderingMVVM
//
//  Created by Alperen Selçuk on 27.03.2022.
//  Copyright © 2022 Alperen Selçuk. All rights reserved.
//

import Foundation

struct OrderListViewModel {
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel {
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}

struct OrderViewModel {
    let order: Order
}

extension OrderViewModel {
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
}
