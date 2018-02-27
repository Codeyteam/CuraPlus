//
//  TableCellTop.swift
//  tableViewdesign
//
//  Created by Ivan Ghazal on 12/7/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit

class TableCellTop: UIView {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var labelName: UILabel!
    
    override func didMoveToSuperview() {
        topView.layer.cornerRadius = 5
     //   topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        topView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        topView.layer.shadowOpacity = 1
        topView.layer.shadowOffset = CGSize(width: 1, height: -2)
        topView.layer.shadowRadius = 2
        
    }
    

}
