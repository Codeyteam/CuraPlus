//
//  Lib.swift
//  Cura
//
//  Created by Ivan Ghazal on 11/30/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import Foundation
import UIKit


func hexStringToUIColor (hex:String , alpha :Double) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(alpha)
    )
}


// change color image
func changeColorImageInButton(button : UIButton , imageName : String , color : UIColor){
    if let origImage = UIImage(named: imageName) {
        let tintedImage = origImage.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        
        button.tintColor = color
    }
    
}

// check box design from Button
class CheckBoxSwitch: UIButton {
    // Images
    let checkedImage = UIImage(named: "checkBox_clicked")! as UIImage
    let uncheckedImage = UIImage(named: "checkBox")! as UIImage
    let color1 = hexStringToUIColor(hex: "#1D9AC1",alpha:0.6)
    let color2 = hexStringToUIColor(hex: "#1D9AC1",alpha:1)
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
                self.setTitleColor(color2, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
                self.setTitleColor(color1, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}

// build shadow effect uiview , button
// same function
// need  to customize it to one code ?????????


//@IBDesignable
class layerShadow: UIView {
    @IBInspectable  var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            //layer.masksToBounds = cornerRadius > 0
            layer.masksToBounds = false
        }
    }
    
    
    @IBInspectable  var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable  var shadowRadius: CGFloat = 0.0  {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable  var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)  {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable  var shadowColor: UIColor? = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0)  {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
    }
}
//@IBDesignable ,UITableView
class buttonShadow: UIButton   {
    @IBInspectable  var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            //layer.masksToBounds = cornerRadius > 0
            layer.masksToBounds = false
        }
    }
    
    
    @IBInspectable  var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable  var shadowRadius: CGFloat = 0.0  {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable  var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)  {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable  var shadowColor: UIColor? = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0)  {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
    }
    
}

//@IBDesignable
class tableViewShadow: UITableView   {
    @IBInspectable  var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            //layer.masksToBounds = cornerRadius > 0
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable  var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable  var shadowRadius: CGFloat = 0.0  {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable  var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)  {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable  var shadowColor: UIColor? = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0)  {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
    }
}

//popup build container

var NewMainScreen : UIView? = nil
var newPopupFrame : UIView? = nil



