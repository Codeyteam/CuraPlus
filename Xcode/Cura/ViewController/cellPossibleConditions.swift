//
//  cellPossibleConditions.swift
//  Cura
//
//  Created by Ivan Ghazal on 12/12/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit
import UICircularProgressRing

class cellPossibleConditions: UITableViewCell {

    
    @IBOutlet weak var conditionName: UILabel!
    @IBOutlet weak var conditionNote: UILabel!
    @IBOutlet weak var conditionPersentage: UICircularProgressRingView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    func animateCirculer(thisCircularProgressRing : UICircularProgressRingView , value : CGFloat){
        UIView.animate(withDuration: 3.9, delay: 0, options: [.curveEaseInOut], animations: {
            
           // thisCircularProgressRing.setProgress(value: 90, animationDuration: 12, completion: nil)
            thisCircularProgressRing.value = value
            
        }, completion:nil)
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
