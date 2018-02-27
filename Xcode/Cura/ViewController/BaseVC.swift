//
//  BaseVC.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 22.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit
import SCLAlertView

class BaseVC: UIViewController {
    let GENDER_MALE = "1";
    let GENDER_FEMALE = "0";
    
    
    let appearance = SCLAlertView.SCLAppearance(kTitleFont: Util.getBoldFont(size: 15), kTextFont: Util.getLightFont(size: 15), kButtonFont: Util.getBoldFont(size: 15),contentViewColor: UIColor.curaWhite(), contentViewBorderColor: UIColor.curaBlue(), titleColor: UIColor.curaBlue())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func setupNavigationBar() {
        let btnRight = UIBarButtonItem(image: UIImage(named: "question"), style: .plain, target: self, action: #selector(BaseVC.btnAboutCura));
        //btnRight.size = CGSize(width: 24, height: 24);
        self.navigationItem.rightBarButtonItem = btnRight;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.tintColor = UIColor.curaBlue()
    }
    
    @objc func btnAboutCura () {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutVC")
        self.navigationController?.pushViewController(vc!, animated: true);
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
