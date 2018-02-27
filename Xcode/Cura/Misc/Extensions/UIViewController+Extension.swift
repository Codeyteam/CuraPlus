//
//  UIViewController+Extension.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 25.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit


extension UIViewController {
    
    
    
    func openPopup(thisUIView :UIView ){
        
        NewMainScreen = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        NewMainScreen?.backgroundColor = hexStringToUIColor(hex: "000000", alpha: 0.4)
        // print("\(String(describing: NewMainScreen))")
        
        thisUIView.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        newPopupFrame = thisUIView
        
        
        
        //CGFloat(Int((NewMainScreen?.center.y)!) - Int((thisUIView.center.y)))
        //    newPopupFrame?.frame = CGRect(x: Int(newPopupFrameX), y: newPopupFrameY, width: newPopupFrameWidth, height: newPopupFrameHieght)
        self.view.addSubview(NewMainScreen!)
        self.view.addSubview(newPopupFrame!)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        newPopupFrame?.alpha = 0
        newPopupFrame?.transform = CGAffineTransform(scaleX: 0.994, y: 0.994)
        newPopupFrame?.center.y -= 300
        
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            self.view.center.y += 5
            
        }, completion: { (finish) in
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                newPopupFrame?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                newPopupFrame?.alpha = 1
                newPopupFrame?.center.y += 300
            })
            
        })
        
    }
    func closePopup(thisUIView :UIView ){
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            newPopupFrame?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            newPopupFrame?.alpha = 0
            newPopupFrame?.center.y -= 140
            
            
            
        }, completion: { (finish) in
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                self.view.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.view.center.y -= 5
                
                
            }, completion: { (finish) in
                newPopupFrame?.center.y += 140
                newPopupFrame?.removeFromSuperview()
                NewMainScreen?.removeFromSuperview()
                newPopupFrame? = thisUIView
                self.tabBarController?.tabBar.isHidden = false
                self.navigationController?.navigationBar.isHidden = false
            })
            
        })
        
    }
}
