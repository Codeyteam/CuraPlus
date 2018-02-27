//
//  ChoosenSemptomsCell.swift
//  
//
//  Created by Ivan Ghazal on 12/7/17.
//

import UIKit

class ChoosenSemptomsCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lineImageView: UIImageView!
    
    @IBOutlet weak var deleteRowButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteRowClicked(_ sender: UIButton) {
    }
    
    

}
