//
//  SymptomModel.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 19.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit

class SymptomModel: Codable {
    var symptomId: Int;
    var name: String;
    var warning: String;
    var questions: [QuestionModel] = [];
    
    init(symptomId: Int, name: String, warning: String) {
        self.symptomId = symptomId;
        self.name = name;
        self.warning = warning;
    }
    convenience init(item: NSDictionary) {
        let symptomId = Util.parseInt(obj: item.object(forKey: "ID"));
        let name = Util.parseString(obj: item.object(forKey: "Name"));
        let warning = Util.parseString(obj: item.object(forKey: "Warning"));
        self.init(symptomId: symptomId, name: name, warning: warning);
    }
}
