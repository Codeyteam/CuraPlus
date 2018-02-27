//
//  conditionPage.swift
//  Cura
//
//  Created by Ivan Ghazal on 12/12/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit

class conditionPage: UIViewController {

    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    @IBOutlet weak var emergency: UITextView!
    @IBOutlet weak var txtDescription: UITextView!
    
    @IBOutlet weak var txtDisease: UILabel!
    
    @IBOutlet weak var txtSymptoms: UILabel!
    
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var callButton: buttonShadow!
    
    
    let emergencytxt = """

                    If you feel any heart attack symptoms, don't wait to get help.
                    Call 911 immediately.
                    Rest until an emergency team arrives.
                    Paramedics may give you an adult-strength aspirin to chew on to help prevent blood clotting.
                    If you are having chest pain and your doctor has prescribed nitroglycerin:
                    Take one dose of nitroglycerin and let it dissolve under your tongue.
                    Wait 5 minutes.
                    If chest pain doesn't improve or gets worse, call 911. The emergency operator will tell you what to do.
                    """
    
    var descriptionTxt = ""
    
    var diseaseName = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var gender = UserDefaults.standard.value(forKey: "gender") as! String
        gender = gender == "0" ? "Female".localized() : "Male".localized()
        txtDisease.text = "\(diseaseName) - \(gender)"
        var symptoms = "";
        for part in Util.selectedSymptoms {
            for sym in part.symptoms {
                symptoms += sym.name + ", "
            }
        }
        txtSymptoms.text = symptoms;
        
        //load data
        emergency.text = emergencytxt
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.lineHeightMultiple = 0
        
        let attributedString:NSMutableAttributedString
      
            attributedString = NSMutableAttributedString(string: descriptionTxt)
        
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(.font, value: Util.getLightFont(size: 16), range: NSMakeRange(0, attributedString.length))
        txtDescription.attributedText = attributedString;
        
        // langauge direction
        if(Util.isRTL()){
            callButton.titleEdgeInsets.left = 0
            callButton.titleEdgeInsets.right = -48
            callButton.imageEdgeInsets.left = 0
            callButton.imageEdgeInsets.right = 58
            
            txtDescription.textAlignment = .right
        }else{
txtDescription.textAlignment = .left
        }
    }

   
    override func viewWillLayoutSubviews() {
        shareButton.roundCorners([.topRight, .bottomRight], radius: 5)
        saveButton.roundCorners([.topLeft, .bottomLeft], radius: 5)
    }
    
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController!.popViewController(animated: true)
            
        
    }
    
    @IBAction func callButtonDidClicked(_ sender: Any) {
        
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
