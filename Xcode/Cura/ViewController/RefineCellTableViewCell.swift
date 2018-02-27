//
//  RefineCellTableViewCell.swift
//  Cura
//
//  Created by Ivan Ghazal on 12/5/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit

class RefineCellTableViewCell: UITableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var radioButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
    @IBAction func radioButtonClicked(_ sender: UIButton) {
        /*
        if radioButton.isSelected {
            radioButton.setImage(#imageLiteral(resourceName: "radioButton_clicked"), for: .normal)
        } else {
            radioButton.setImage(#imageLiteral(resourceName: "radioButton"), for:.normal)
        }
        radioButton.isSelected = !radioButton.isSelected
        */
    }
    func selectedRadio(){
        radioButton.setImage(#imageLiteral(resourceName: "radioButton_clicked"), for: .normal)
    }
    
    func unSelectedRadio(){
         radioButton.setImage(#imageLiteral(resourceName: "radioButton"), for:.normal)
    }
}
