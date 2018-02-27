//
//  UIImageView+Extension.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 25.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
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

