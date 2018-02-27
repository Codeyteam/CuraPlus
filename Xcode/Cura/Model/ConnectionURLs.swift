//
//  ConnectionURLs.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 19.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit

class ConnectionURLs: NSObject {
    class func getBaseURL() -> String {
        
        return "http://178.162.200.110:8002/api/";
    }
    
    class func getSiteURL() -> String {
        return "http://178.162.200.110:8002/";
    }
    
    class func getSymptomsUrl(gender: String) -> String {
        return "\(getBaseURL())BodyParts/ByGender/\(gender)";
    }
    class func getSymptomsUrl(bodyPartId: Int) -> String {
        return "\(getBaseURL())BodyParts/ByID/\(bodyPartId)";
    }
    
    class func getSymptomsUrl() -> String {
        return "\(getBaseURL())Symptoms";
    }
    
    class func getQuestionsUrl(symId: Int) -> String {
        return "\(getBaseURL())SymptomQuestions/\(symId)";
    }
    
    class func getDiseasesUrl() -> String {
        return "\(getBaseURL())Diseases/BySymptoms";
    }
   
    class func getContactDrUrl() -> String {
        return "\(getBaseURL())ContactDr";
    }
    class func getContactUsUrl() -> String {
        return "\(getBaseURL())ContactUs";
    }
    
}
