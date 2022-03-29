//
//  OrderTableViewCell.swift
//  CoffeeOrderingMVVM
//
//  Created by Alperen Selçuk on 24.03.2022.
//  Copyright © 2022 Alperen Selçuk. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    static let reuseIdentifier = "order-cell-reuse-identifier"
    
    var productNameTextLabel = UILabel()
    var sizeTextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OrderTableViewCell {
    fileprivate func setup() {
        productNameTextLabel.text = "deneme"
        productNameTextLabel.font = UIFont.systemFont(ofSize: 16)
        productNameTextLabel.numberOfLines = 0
        productNameTextLabel.lineBreakMode = .byTruncatingTail
        
        sizeTextLabel.text = "deneme"
        sizeTextLabel.font = UIFont.systemFont(ofSize: 16)
        sizeTextLabel.numberOfLines = 1
        sizeTextLabel.lineBreakMode = .byTruncatingTail
                
        contentView.backgroundColor = .systemGray5
        
        contentView.addSubview(productNameTextLabel)
        contentView.addSubview(sizeTextLabel)
        
    }

    override func layoutSubviews() {
        productNameTextLabel.frame = CGRect(x: contentView.frame.width - 85,
                                            y: 0,
                                            width: 85,
                                            height: 32)
        
        sizeTextLabel.frame = CGRect(x: 5,
                                     y: 0,
                                     width: 85,
                                     height: 32)
    }
}
