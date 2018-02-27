//
//  Footer.swift
//  Cura
//
//  Created by Ivan Ghazal on 11/30/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit

class Footer: UITabBarController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func viewDidLoad() {
        tabBar.backgroundColor = UIColor.white
        tabBar.layer.borderWidth = 0
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        tabBar.layer.shadowRadius = 1
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.12
        tabBar.tintColor = UIColor.white
        //tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        
        let mainButton = ["home","conditions","saved","contact"]
        let mainButtonClicked = ["home_clicked","conditions_clicked","saved_clicked","contact_clicked"]
        
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
        
        self.tabBar.items?[i].selectedImage = UIImage(named: mainButtonClicked[i])?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[i].image = UIImage(named: mainButton[i])?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[i].title = nil
        self.tabBar.items?[i].imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        var tabFrame            = tabBar.frame
        tabFrame.size.height    = 81
        tabFrame.origin.y       = view.frame.size.height - 81
        tabBar.frame            = tabFrame

    }
    

}
