//
//  UIColor+Extension.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 22.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func curaBlue() -> UIColor {
        return UIColor(red: 28/255, green: 153/255, blue: 192/255, alpha: 1);
    }
    
    static func curaUIntBlue() -> UInt {
        return 0x1c99c0;
    }
    static func curaUIntRed() -> UInt {
        return 0xff0000;
    }
    
    
    static func curaWhite() -> UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1);
    }
}
