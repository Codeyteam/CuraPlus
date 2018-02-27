//
//  AnswerModel.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 20.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit

class AnswerModel: Codable {
    var answerId: Int;
    var answerBody: String;
    var warning: String;
    var isSelected: Bool = false;
    
    
    init(answerId: Int, answerBody: String, warning: String) {
        self.answerId = answerId;
        self.answerBody = answerBody;
        self.warning = warning;
    }
    convenience init(item: NSDictionary) {
        let answerId = Util.parseInt(obj: item.object(forKey: "ID"));
        let answerBody = Util.parseString(obj: item.object(forKey: "AnswerBody"));
        let warning = Util.parseString(obj: item.object(forKey: "Warning"));
        
        self.init(answerId: answerId, answerBody: answerBody, warning: warning);
    }
}
