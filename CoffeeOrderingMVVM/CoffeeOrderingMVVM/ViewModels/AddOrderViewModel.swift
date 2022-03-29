//
//  AddOrderViewModel.swift
//  CoffeeOrderingMVVM
//
//  Created by Alperen Selçuk on 27.03.2022.
//  Copyright © 2022 Alperen Selçuk. All rights reserved.
//

import Foundation

struct AddOrderViewModel {
    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] { return CoffeeType.allCases.map { $0.rawValue.capitalized } }
    
    var sizes: [String] { return CoffeeSize.allCases.map {$0.rawValue.capitalized} }
    
}
