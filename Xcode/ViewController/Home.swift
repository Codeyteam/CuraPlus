//
//  FirstViewController.swift
//  Cura
//
//  Created by Ivan Ghazal on 11/30/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit

// hide keyboard
extension UIViewController {
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}




class Home: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var checkBox: CheckBoxSwitch!
    
    // for language designe
    
    @IBOutlet weak var iAgreeConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        changeColorImageInButton(button: nextButton, imageName: "arrow_right", color: .white)
        
        self.navigationItem.rightBarButtonItem?.image? = (UIImage(named: "user")?.withRenderingMode(.alwaysOriginal))!
        self.navigationItem.leftBarButtonItem?.image? = (UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal))!
        
            //disable next button
        nextButton.isEnabled = false
        nextButton.alpha = 0.3
        
        // hide keyboard
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        
        
        
        // langauge direction
        if(Helper.isRTL()){
            nextButton.imageEdgeInsets.right = 160
            nextButton.imageEdgeInsets.left = 0
            iAgreeConstraint.constant = 58
            
        }else{
            nextButton.imageEdgeInsets.left = 160
            nextButton.imageEdgeInsets.right = 0
        }
        
        // active gender picker on load
        self.pickUp(genderTextField)
        
    }

    // hide keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
        // do aditional stuff
    }

    
    @IBAction func checkBoxCliked(_ sender: CheckBoxSwitch) {
        

        if  checkBox.isChecked == true {
            nextButton.alpha = 0.3
            nextButton.isEnabled = false
            print("UnChecked")
            
        }else if checkBox.isChecked == false{

            nextButton.alpha = 1
            nextButton.isEnabled = true
            print("Checked")
        }
    }
    
    @IBAction func nextButtonDidTouch(_ sender: UIButton) {
        
        performSegue(withIdentifier: "showBodySeque", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MySemptomsBody {
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
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(Home.doneClick))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(Home.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = pickerDataStatuse
        textField.inputAccessoryView = toolBar
        
    }
    
    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            pickerDataStatuse = true
        }else if row == 1{
            pickerDataStatuse = false
        }
        self.genderTextField.text = pickerData[row]
    }
    //MARK:- TextFiled Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
       // self.pickUp(genderTextField)
    }

    
    //MARK:- Button
    @objc func doneClick() {
        
        genderTextField.resignFirstResponder()
    }
    @objc func cancelClick() {
        genderTextField.resignFirstResponder()
    }
    
   
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

