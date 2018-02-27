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
    
    let descriptionTxt = """
                    Heart Attack (Female) Symptoms
                    Discomfort, tightness, pressure, fullness, or crushing pain in the chest; pain in the back, jaw, neck, shoulders, or arms (which may radiate from the chest); shortness of breath; profuse sweating; nausea or vomiting; exhaustion or weakness; stomach or abdominal pain; anxiety; new or worse headaches

                    Overview
                    A heart attack occurs when blood flow to the heart muscle is reduced or stopped by blockage in one or more arteries. If blood supply is cut off for more than a few minutes, you may become disabled or die. Getting emergency treatment can limit or prevent damage to the heart and save your life. Women are less likely than men to believe they're having a heart attack and less likely get help right away. Some women mistakenly think heart attacks cause only chest pain. But a woman having a heart attack may just feel extreme weakness or fatigue, fullness in the chest, or back pain between the shoulder blades. Some may feel only nausea or shortness of breath. Women can't control some risk factors for heart attacks, such as age or heredity, but can control many others.

                    Visit the Heart Attack Directory



                    """
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        shareButton.layer.cornerRadius = 5
        shareButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        saveButton.layer.cornerRadius = 5
        saveButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        //load data
        emergency.text = emergencytxt
        txtDescription.text = descriptionTxt
        
        // langauge direction
        if(Helper.isRTL()){
            shareButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            saveButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            callButton.titleEdgeInsets.left = 0
            callButton.titleEdgeInsets.right = -48
            callButton.imageEdgeInsets.left = 0
            callButton.imageEdgeInsets.right = 58
        }else{

        }
    }

   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
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
