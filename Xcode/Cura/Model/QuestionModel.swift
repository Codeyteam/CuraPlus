//
//  QuestionModel.swift
//  Cura
//
//  Created by Ammar AbdulSalam on 20.01.2018.
//  Copyright © 2018 Ivan Ghazal. All rights reserved.
//

import UIKit

class QuestionModel: Codable {
    var questionId: Int;
    var isMultiple: Bool;
    var questionBody: String;
    var answers: [AnswerModel] = [];
    
    
    init(questionId: Int, isMultiple: Bool, questionBody: String) {
        self.questionId = questionId;
        self.isMultiple = isMultiple;
        self.questionBody = questionBody;
    }
    convenience init(item: NSDictionary) {
        let questionId = Util.parseInt(obj: item.object(forKey: "ID"));
        let isMultiple = Util.parseBool(obj: item.object(forKey: "IsMultiple"));
        let questionBody = Util.parseString(obj: item.object(forKey: "QuestionBody"));
        self.init(questionId: questionId, isMultiple: isMultiple, questionBody: questionBody);
        
        if let answersDict = item.object(forKey: "Answers") as? [NSDictionary] {
            for answerItem in answersDict {
                let aModel = AnswerModel(item: answerItem);
                self.answers.append(aModel);
            }
        }
        
    }
}
