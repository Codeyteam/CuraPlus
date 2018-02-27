//
//  ContactUsVC.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 27.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire

class ContactUsVC: BaseVC {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet var thankYou: UIView!
    
    @IBOutlet weak var callDoctorContainerView: UIView!
    
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var txtMessage: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        changeColorImageInButton(button: sendButton, imageName: "arrow_right", color: .white)
        
        
        // hide keyboardظظ self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        
        
        // langauge direction
        if(Util.isRTL()){
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
        
        if txtFullName.text == "" {
            SCLAlertView(appearance: appearance).showInfo("", subTitle: "Please type your name!".localized())
            return;
        }
        
        if txtFullName.text == "" {
            SCLAlertView(appearance: appearance).showInfo("", subTitle: "Please type your phone number!".localized())
            return;
        }
        
        
        sendMessage();
        
    }
    
    @IBAction func backButtonDidTouch(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
        
    }
    
    
    func sendMessage() {
        
        SwiftLoader.show(animated: true);
        
        
        let url = ConnectionURLs.getContactUsUrl();
        // debugPrint(url)
        let params : Parameters =  [
            "FullName": self.txtFullName.text!,
            "Phone": self.txtPhone.text!,
            "Message": self.txtMessage.text!
        ]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: Util.getRequestHeaders()).responseJSON { response in
            
          //  if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                self.callDoctorContainerView.layer.zPosition = 10
                let startY = self.callDoctorContainerView.frame.size.height + self.callDoctorContainerView.layer.position.y + 10
                let heightThankYou = self.view.frame.height - startY
                self.thankYou.frame = CGRect(x: 0, y: startY, width: self.view.frame.width, height: heightThankYou)
                
                self.view.addSubview(self.thankYou)
          //  }
        }
        SwiftLoader.hide();
    }
    
    
}
