//
//  FirstViewController.swift
//  Cura
//
//  Created by Ivan Ghazal on 11/30/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit
import SCLAlertView
import AlertOnboarding

class HomeVC: BaseVC , UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet var popupSettings: layerShadow!
    
    @IBOutlet weak var chkAgreement: UISwitch!
    
    @IBOutlet weak var segmentLanguage: UISegmentedControl!
    
    
    @IBOutlet weak var lblWelcom: UILabel!
    
    
    var gender = "0";
    // for language designe
    
   // @IBOutlet weak var iAgreeConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lblWelcom.linespace
        changeColorImageInButton(button: nextButton, imageName: "arrow_right", color: .white)
        
        
        let oldLanguage = Util.parseString(obj: UserDefaults.standard.value(forKey: "lang"))
        
        if(oldLanguage == "ar") {
            segmentLanguage.selectedSegmentIndex = 1
        }
        else {
            segmentLanguage.selectedSegmentIndex = 0
        }
        
        //self.navigationItem.rightBarButtonItem?.image? = (UIImage(named: "user")?.withRenderingMode(.alwaysOriginal))!
        //self.navigationItem.leftBarButtonItem?.image? = (UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal))!
        
            //disable next button
        //nextButton.isEnabled = false
        //nextButton.alpha = 0.3
        
        lblWelcom.setLineSpacing(lineSpacing: 6, lineHeightMultiple: 0);
        
        // langauge direction
        if(Util.isRTL()){
            nextButton.imageEdgeInsets.right = 160
            nextButton.imageEdgeInsets.left = 0
            //iAgreeConstraint.constant = 58
            
        }else{
            nextButton.imageEdgeInsets.left = 160
            nextButton.imageEdgeInsets.right = 0
        }
        
        // active gender picker on load
        self.pickUp(genderTextField)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Util.selectedSymptoms = []
        var isIntroShown = UserDefaults.standard.bool(forKey: "isIntroShown");
            if !isIntroShown {
                let arrayOfImage = ["slide1", "slide2", "slide3"]
                let arrayOfTitle = ["", "", ""]
                let arrayOfDescription = ["IntroPage1".localized(),
                                          "IntroPage2".localized(),
                                          "IntroPage3".localized()]
                
                //Simply call AlertOnboarding...
                let alertView = AlertOnboarding(arrayOfImage: arrayOfImage, arrayOfTitle: arrayOfTitle, arrayOfDescription: arrayOfDescription)
                alertView.frame = self.view.frame;
                //... and show it !
                   alertView.show()
                
                UserDefaults.standard.set(true, forKey: "isIntroShown");
            }
        
        
        
    }
    
    
    @IBAction func sgmntLanguage(_ sender: UISegmentedControl) {
        
        
        
        
        
        switch (sender.selectedSegmentIndex) {
        case 0:
            UserDefaults.standard.set("en", forKey: "lang");
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            break;
        case 1:
            UserDefaults.standard.set("ar", forKey: "lang");
            UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            break;
            
            
            
            
        default:
            break;
        }
        
        let appearance = SCLAlertView.SCLAppearance(kTitleFont: Util.getBoldFont(size: 15), kTextFont: Util.getLightFont(size: 15), kButtonFont: Util.getBoldFont(size: 15),showCloseButton: false, contentViewColor: UIColor.curaWhite(), contentViewBorderColor: UIColor.curaBlue(), titleColor: UIColor.curaBlue())
        
        let alert = SCLAlertView(appearance: appearance);
        
        alert.addButton("Done".localized()) {
            exit(0);
        }
        
        
        
        alert.showInfo("", subTitle: "App will close to apply new settings".localized(), colorStyle: UIColor.curaUIntBlue());
     
    }
    
    
    
    @IBAction func switchTour(_ sender: UISwitch) {
        
        if sender.isOn {
            UserDefaults.standard.set(false, forKey: "isIntroShown");
        }
        else {
            UserDefaults.standard.set(true, forKey: "isIntroShown");
        }
        UserDefaults.standard.synchronize()
    }
    
    
    
    
    @IBAction func showPopup(_ sender: UIBarButtonItem) {
        
        popupSettings.frame = CGRect(x: 0, y: 0, width: self.view.frame.width-48, height: 320)
        
        openPopup(thisUIView: popupSettings);
        
    }
    
    @IBAction func btnClosePopup(_ sender: UIButton) {
        
        closePopup(thisUIView: popupSettings)
        
    }
    
    @IBAction func nextButtonDidTouch(_ sender: UIButton) {
        if(!chkAgreement.isOn) {
            SCLAlertView(appearance: appearance).showInfo("", subTitle: "Please Accept Agreement!".localized(), closeButtonTitle:"Done".localized(), colorStyle: UIColor.curaUIntBlue());
            return;
        }
        
        if(gender == "") {
            SCLAlertView(appearance: appearance).showInfo("", subTitle: "Please select gender!".localized(), closeButtonTitle:"Done".localized(), colorStyle: UIColor.curaUIntBlue());
            return;
        }
        
        if(ageTextField.text == "") {
            SCLAlertView(appearance: appearance).showInfo("", subTitle: "Please fill your age!".localized(), closeButtonTitle:"Done".localized(), colorStyle: UIColor.curaUIntBlue());
            return;
        }
        
        
        
        UserDefaults.standard.set(gender, forKey: "gender")
        UserDefaults.standard.set(ageTextField.text, forKey: "age")
        
        performSegue(withIdentifier: "showBodySeque", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BodyPartsVC {
            destination.myPersionalData.0 = Int(ageTextField.text!)!
            destination.myPersionalData.1 = pickerDataStatuse
        }
    }
     
     
     
    // picker view for gender
    var myPickerView : UIPickerView!
    var pickerData = ["Male".localized() , "Female".localized() ]
    var pickerDataStatuse = true
    
    func pickUp(_ textField : UITextField){
        
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        
    }
    
    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.genderTextField.text == "" {
        self.genderTextField.text = pickerData[0]
        }
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {//Male
            pickerDataStatuse = true
            gender = GENDER_MALE;
            
        }else if row == 1{//Female
            
            gender = GENDER_FEMALE;
            
            pickerDataStatuse = false
        }
        self.genderTextField.text = pickerData[row]
    }
   
}

