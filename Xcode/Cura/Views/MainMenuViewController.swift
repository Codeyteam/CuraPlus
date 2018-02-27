//
//  MainMenuViewController.swift
//  Cura
//
//  Created by Ivan Ghazal on 12/6/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit

class MainMenuViewController: UINavigationController {

    @IBOutlet weak var mainMenu: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       mainMenu.barTintColor =  hexStringToUIColor(hex: "1D9AC1", alpha: 1.0)
        mainMenu.backgroundColor =  hexStringToUIColor(hex: "1D9AC1", alpha: 1.0)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        


    }



    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
