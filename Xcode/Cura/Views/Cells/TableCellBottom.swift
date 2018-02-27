//
//  TableCellBottom.swift
//  tableViewdesign
//
//  Created by Ivan Ghazal on 12/7/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit
import Foundation

class TableCellBottom: UIView {

    @IBOutlet weak var bottomView: UIView!
    
    override func didMoveToSuperview() {
        bottomView.layer.cornerRadius = 5
    //    bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        bottomView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowOffset = CGSize(width: 1, height: 4)
        bottomView.layer.shadowRadius = 3
        
    }



}
