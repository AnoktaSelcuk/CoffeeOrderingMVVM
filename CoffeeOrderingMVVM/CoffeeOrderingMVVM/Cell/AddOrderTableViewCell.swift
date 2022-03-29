//
//  AddOrderTableViewCell.swift
//  CoffeeOrderingMVVM
//
//  Created by Alperen Selçuk on 24.03.2022.
//  Copyright © 2022 Alperen Selçuk. All rights reserved.
//

import UIKit

class AddOrderTableViewCell: UITableViewCell {

    static let reuseIdentifier = "AddOrder-cell-reuse-identifier"
      

      let textLabel1 = UILabel()
      
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          setup()
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
}

extension AddOrderTableViewCell {
    fileprivate func setup() {
        textLabel1.text = "deneme"
        textLabel1.font = UIFont.systemFont(ofSize: 16)
        textLabel1.numberOfLines = 0
        textLabel1.lineBreakMode = .byTruncatingTail
        
        contentView.addSubview(textLabel1)

    }

    override func layoutSubviews() {
        textLabel1.frame = CGRect(x: 5,
                                  y: 5,
                                  width: contentView.frame.width,
                                  height: contentView.frame.height / 2)
        
    }
}
