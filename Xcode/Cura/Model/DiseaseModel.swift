//
//  DiseaseModel.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 25.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit

class DiseaseModel: Codable {
    
    var name: String;
    var desc: String;
    var subCategory: String;
    var percent: Int;

    init(name: String, desc: String, subCategory: String, percent: Int) {
        self.name = name;
        self.desc = desc;
        self.subCategory = subCategory;
        self.percent = percent;
    }
    convenience init(item: NSDictionary) {
        let name = Util.parseString(obj: item.object(forKey: "Name"));
        let desc = Util.parseString(obj: item.object(forKey: "Description"));
        let subCategory = Util.parseString(obj: item.object(forKey: "SubCategory"));
        let percent = Util.parseInt(obj: item.object(forKey: "Percent"));
        self.init(name: name, desc: desc, subCategory: subCategory, percent: percent);
    }
}
