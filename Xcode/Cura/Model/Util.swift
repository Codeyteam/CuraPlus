//
//  Util.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 1/2/18.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class Util: NSObject {
    
    
    
    class func parseInt(obj: Any?) -> Int{
        
        if let n = obj as? Int {
            return n;
        }
        return 0;
    }
    
    class func parseBool(obj: Any?) -> Bool {
        
        if let n = obj as? Bool {
            return n;
        }
        
        if let n = obj as? Int {
            return n == 1;
        }
        
        return false;
    }
    
    class func parseFloat(obj: Any?) -> Float{
        
        if let n = obj as? Float {
            return n;
        }
        return 0;
    }
    
    class func parseDouble(obj: Any?) -> Double{
        
        if let n = obj as? Double {
            return n;
        }
        return 0;
    }
    
    class func parseString(obj: Any?) -> String{
        
        if let n = obj as? String {
            return n;
        }
        return "";
    }
    
    class func parseDate(strTime: String) -> Date? {
        let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let d = formatter.date(from: strTime) {
            return d;
        }
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        
        if let d = formatter.date(from: strTime) {
            return d;
        }
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let d = formatter.date(from: strTime) {
            return d;
        }
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let d = formatter.date(from: strTime) {
            return d;
        }
        return nil;
    }
    
    
    
    
    class func isRTL() -> Bool {
        
        let lang = Util.parseString(obj: UserDefaults.standard.value(forKey: "lang"))
            if lang == "ar" {
                return true;
            }
        
        
        return false;
    }
    
    class func getLang() -> String {
        if(isRTL()) {
            return "ar";
        }
        return "en";
    }




    class func getLightFont(size: Int) -> UIFont{
        if(isRTL()) {
            if let font = UIFont(name: "Hacen Tunisia Lt", size: CGFloat(size)) {
                return font;
            }
        }
        else {
            if let font = UIFont(name: "Campton", size: CGFloat(size)) {
                return font;
            }
        }
        return UIFont.systemFont(ofSize: CGFloat(size));
    }
    
    class func getBoldFont(size: Int) -> UIFont {
        if Util.isRTL() {
            return UIFont(name: "Hacen Tunisia Lt", size: CGFloat(size))!;
        }
        
        
        return UIFont(name: "CamptonW00-Bold", size: CGFloat(size))!;
    }
    
    class func getRequestHeaders() -> HTTPHeaders {
        
       // let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
      //  var location = "0,0";
        
        
        
        var ver = "";
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            ver = version;
        }
        
        let headers: HTTPHeaders = [
            "Language" : Util.getLang(),
            "Version"  : ver,
            "App"      : "IOS",
            "Device"   : UIDevice.current.modelName
        ]
        
        
        debugPrint(headers);
        return headers;
    }
    
    
    static var selectedSymptoms : [BodyPartModel] = [];
    
}
