//
//  Order.swift
//  CoffeeOrderingMVVM
//
//  Created by Alperen Selçuk on 27.03.2022.
//  Copyright © 2022 Alperen Selçuk. All rights reserved.
//

import Foundation


enum CoffeeType: String, Codable, CaseIterable {
    case Latte
    case espressino
    case cortado
    case coppuccino
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}

extension Order {
    

    static var all: Resource<[Order]> = {
        guard let url = URL(string: ":)") else { fatalError("URL is incorrect")}

        return Resource<[Order]>(url: url)
    }()
    
    static func create(vm: AddOrderViewModel) -> Resource<Order?> {
        let order = Order(vm)
        guard let url = URL(string: ":)") else { fatalError("URL is incorrect")}

        guard let data = try? JSONEncoder().encode(order) else { fatalError("Error encoding the order") }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethot = HttpMethod.post
        resource.body = data
        
        return resource
    }
}

extension Order {
    
    init?(_ vm: AddOrderViewModel) {
        guard let name = vm.name,
            let email = vm.email,
            let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
            let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased())
            else {
                return nil
            }
        
           self.name = name
           self.email = email
           self.type = selectedType
           self.size = selectedSize
    }
}
