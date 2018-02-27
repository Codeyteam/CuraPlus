//
//  MySemptomsBody.swift
//  Cura
//
//  Created by Ivan Ghazal on 12/2/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit
import AlertOnboarding


class BodyPartsVC: BaseVC {

    var bodyPartsColors = ["Head":"A3A5A5" , "Forehead ":"EDE1B8" , "Eye":"E0D4AA" , "Nose ":"FFF4DD" , "Mouth":"EFE2B6" , "Ears":"D1C59C" , "Chin":"FFF2C8" , "Others":"F4E9C4" , "Neck":"FFE9CC" , "Arm":"FF0000" , "Chest":"E3D8C2" , "Back":"FFDCA1" , "Pelvis":"F2E1C5" , "Trunk":"EBDFCB" , "Butt":"F2E1CC" , "Leg":"FFEFDD"]
  
        var bodyPartsIds = ["Head":"0" , "Forehead ":"1" , "Eye":"2" , "Nose ":"4" , "Mouth":"5" , "Ears":"3" , "Chin":"1" , "Others":"1" , "Neck":"7" , "Arm":"13" , "Chest":"8" , "Back":"10" , "Pelvis":"11" , "Trunk":"12" , "Butt":"14" , "Leg":"12"]
   // var bodyPartsIds = [0, 1, 2, 4, 5, 3, 1, 1, 7, 13, 8, 10, 11, 12, 14, 12]
    
/*    Eyes
    Ears
    Nose
    Mouth
    Back_Neck
    Neck
    Chest
    Stomach
    Back
    Pelivs
    Legs
    Hand
    Back_Pelvis
    Skin
    
    */
    
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar();
       
        
        print("\(String(describing: myPersionalData.0)) - \(String(describing: myPersionalData.1)) ")
        //remove topmenu and footer 
       // self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
        
        switchButton.layer.zPosition = 10
        let gender = UserDefaults.standard.object(forKey: "gender") as! String;
        // declare for segue destination
            if gender == GENDER_MALE {
            //choose gender
           bodyImages = manImages
            }else if gender == GENDER_FEMALE {
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

        // langauge direction
        if(Util.isRTL()){
            showBodyButton.imageEdgeInsets.left = 26
            showListButton.imageEdgeInsets.left = 26
            showBodyButton.imageEdgeInsets.right = 0
            showListButton.imageEdgeInsets.right = 0
        }else{
        }
        

        
        tappedImageView.contentMode =  UIViewContentMode.scaleAspectFit

        
        }
    
    override func viewWillLayoutSubviews() {
        showBodyButton.roundCorners([.topRight, .bottomRight], radius: 5)
        showListButton.roundCorners([.topLeft, .bottomLeft], radius: 5)
    }
    
    
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
        
        //chooseLabel.backgroundColor = thisPointColor
        print("\(hexStringToUIColor(hex: "0039FF", alpha: 1))")
        print("\(thisPointColor)")
        var index = 0;
        for i in bodyPartsColors {
            if thisPointColor == hexStringToUIColor(hex: i.value, alpha: 1) {
                chooseLabel.text = i.key
                
//                if(self.bodyPartsIds[index] > 0){
                let vc = storyboard?.instantiateViewController(withIdentifier: "SymptomsListVC") as! SymptomsListVC
                debugPrint(self.bodyPartsIds[i.key]!);
                
                vc.bodyPartId = Int(self.bodyPartsIds[i.key]!)!;
                self.navigationController?.pushViewController(vc, animated: true);
                }
  //          }
            index += 1;
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
