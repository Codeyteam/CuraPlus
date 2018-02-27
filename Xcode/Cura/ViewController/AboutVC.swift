//
//  AboutVC.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 25.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit

class AboutVC: BaseVC {

    @IBOutlet weak var lblText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblText.setLineSpacing(lineSpacing: 6, lineHeightMultiple: 0);
        lblText.textAlignment = .center;
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.tintColor = UIColor.curaWhite()
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
