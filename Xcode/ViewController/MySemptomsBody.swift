//
//  MySemptomsBody.swift
//  Cura
//
//  Created by Ivan Ghazal on 12/2/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit

// this extension use to get pixel color from image and work only in @x1 image res
extension UIImageView {
    
    func getPixelColor(atLocation location: CGPoint, withFrameSize size: CGSize) -> UIColor {
        
        //self.contentMode = UIViewContentMode.scaleAspectFit
        let x: CGFloat = (self.image!.size.width) * location.x / size.width
        let y: CGFloat = (self.image!.size.height) * location.y / size.height
        
        let pixelPoint: CGPoint = CGPoint(x: x, y: y)
        
        let pixelData = self.image!.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelIndex: Int = ((Int(self.image!.size.width) * Int(pixelPoint.y)) + Int(pixelPoint.x)) * 4
        
        let r = CGFloat(data[pixelIndex]) / CGFloat(255.0)
        let g = CGFloat(data[pixelIndex+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelIndex+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelIndex+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
}


class MySemptomsBody: UIViewController {

    var bodyPartsColors = ["Head":"A3A5A5" , "Forehead ":"EDE1B8" , "Eye":"E0D4AA" , "Nose ":"FFF4DD" , "Mouth":"EFE2B6" , "Ears":"D1C59C" , "Chin":"FFF2C8" , "Others":"F4E9C4" , "Neck":"FFE9CC" , "Arm":"FF0000" , "Chest":"E3D8C2" , "Back":"FFDCA1" , "Pelvis":"F2E1C5" , "Trunk":"EBDFCB" , "Butt":"F2E1CC" , "Leg":"FFEFDD"]
  
    var bodyImages : [String:String]?
    let manImages = ["front":"man_front","frontParts":"man_front_parts","back":"man_back","backParts":"man_back_parts"]
      let womenImages = ["front":"women_front","frontParts":"women_front_parts","back":"women_back","backParts":"women_back_parts"]
    
    // declare for segue destination
    var myPersionalData :(Int , Bool) = (0 , true)
    
    @IBOutlet weak var layoutBody1: UIView!
    @IBOutlet weak var layoutBody2: UIView!
    
    @IBOutlet weak var showBodyButton: UIButton!
    @IBOutlet weak var showListButton: UIButton!
    
    @IBOutlet weak var switchButton: UIButton!
    var bodyImageStatus = true
    
    
    @IBOutlet weak var chooseLabel: UILabel!
    
    // add images body
    @IBOutlet weak var tappedImageView: UIImageView!
    
    @IBOutlet weak var theBodyImageView: UIImageView!
    @IBOutlet var bodyTappedGestureRecongniser: UITapGestureRecognizer!
    
    @IBOutlet weak var switchImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(String(describing: myPersionalData.0)) - \(String(describing: myPersionalData.1)) ")
        //remove topmenu and footer 
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
        
        switchButton.layer.zPosition = 10
        
        // declare for segue destination
            if myPersionalData.1 == true {
            //choose gender
           bodyImages = manImages
            }else if myPersionalData.1 == false {
                bodyImages = womenImages
            }
        
        
        
        //bodyImages = manImages
        tappedImageView.image = UIImage(named : bodyImages!["frontParts"]!)
        theBodyImageView.image =  UIImage(named : bodyImages!["front"]!)
        switchImageView.image =  UIImage(named : bodyImages!["back"]!)
        
        
        //fix button image color
        changeColorImageInButton(button: showBodyButton, imageName: "body", color: .white)
        let orangecolore = hexStringToUIColor(hex: "F77C12", alpha: 1.0)
        changeColorImageInButton(button: showListButton, imageName: "list", color: orangecolore)
        showBodyButton.layer.cornerRadius = 5
        showBodyButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        showListButton.layer.cornerRadius = 5
        showListButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        

 
        
        // langauge direction
        if(Helper.isRTL()){
            showBodyButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            showListButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            showBodyButton.imageEdgeInsets.left = 26
            showListButton.imageEdgeInsets.left = 26
            showBodyButton.imageEdgeInsets.right = 0
            showListButton.imageEdgeInsets.right = 0
        }else{
            showBodyButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            showListButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        

        
        tappedImageView.contentMode =  UIViewContentMode.scaleAspectFit

        
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
    
    
    
    @IBAction func switchBodyClicked(_ sender: Any)  {
      
        if bodyImageStatus == true {
            //resetLayerBody()
            tappedImageView.image = UIImage(named : bodyImages!["backParts"]!)
            theBodyImageView.image =  UIImage(named : bodyImages!["back"]!)

            switchImageView.image =  UIImage(named : bodyImages!["front"]!)

            bodyImageStatus = false
        }else{
            tappedImageView.image = UIImage(named : bodyImages!["frontParts"]!)
            theBodyImageView.image =  UIImage(named : bodyImages!["front"]!)
            
            switchImageView.image =  UIImage(named : bodyImages!["back"]!)
            bodyImageStatus = true
        }
        
    }
    

    

    
   
    @IBAction func bodyTappedDidTouch(_ sender: Any) {
     
        // get x,y from tapped point
        let xx = bodyTappedGestureRecongniser.location(in: tappedImageView).x
        let yy = bodyTappedGestureRecongniser.location(in: tappedImageView).y
        let location = CGPoint(x: xx, y: yy)
        let thisPointColor = tappedImageView.getPixelColor(atLocation: location, withFrameSize: tappedImageView.frame.size)
        //self.view.backgroundColor = thisPointColor
        
        chooseLabel.backgroundColor = thisPointColor
        print("\(hexStringToUIColor(hex: "0039FF", alpha: 1))")
        print("\(thisPointColor)")
        
        for i in bodyPartsColors {
            if thisPointColor == hexStringToUIColor(hex: i.value, alpha: 1) {
                chooseLabel.text = i.key
            }
        }
        
        // if its head
        if thisPointColor == hexStringToUIColor(hex: "0039FF", alpha: 1) {
            //headView.isHidden = false
            tappedImageView.image = UIImage(named : "head_parts")
            theBodyImageView.image =  UIImage(named : "head")
            switchImageView.image =  UIImage(named : bodyImages!["front"]!)
            bodyImageStatus = false
        }
        
    
    }
    
  
    
    
}
