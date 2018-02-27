//
//  CallDoctorViewController.swift
//  Cura
//
//  Created by Ivan Ghazal on 1/4/18.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//



import UIKit

class CallDoctorViewController: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        changeColorImageInButton(button: sendButton, imageName: "arrow_right", color: .white)

        
        // hide keyboardظظ self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        
        
        // langauge direction
        if(Helper.isRTL()){
            sendButton.imageEdgeInsets.left = 0
            sendButton.imageEdgeInsets.right = 130
            
        }else{

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func sendButtonDidTouch(_ sender: Any) {
    }
    
    @IBAction func backButtonDidTouch(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)

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
