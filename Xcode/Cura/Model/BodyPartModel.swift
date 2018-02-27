//
//  BodyPartModel.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 20.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import Foundation

class BodyPartModel : Codable {

    var title: String;
    var symptoms: [SymptomModel] = [];
    
    
    init(title: String) {
        self.title = title;
    }
    convenience init(item: NSDictionary) {
        let title = Util.parseString(obj: item.object(forKey: "Title"));
        self.init(title: title);
        
        if let symDict = item.object(forKey: "Symptoms") as? [NSDictionary] {
            for symItem in symDict {
                let sModel = SymptomModel(item: symItem);
                self.symptoms.append(sModel);
            }
        }
    }
}
