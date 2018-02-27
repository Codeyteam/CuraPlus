//
//  MySemptomsList.swift
//  Cura
//
//  Created by Ivan Ghazal on 12/2/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit
import Localize_Swift
import Alamofire
import SCLAlertView

class SymptomsListVC: BaseVC, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var showBodyButton: UIButton!
    
    @IBOutlet weak var showListButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    // array data
    
    //var section = ["Head"]
    var bodyPartsList : [BodyPartModel] = [];
    var filtered:[BodyPartModel] = [];
    
    //var data : [String] = ["Agitation".localized(),"Anxiety".localized(),"Apathy","Bald spot (Hair)","Blackouts".localized(),"Bleeding","Seattle","Brittle Hair","Broken Bone","Coma","Compulsive behavior","Confusion","Craving alchohol","Craving to eat ice , dirt or paper","Crawling sensation","Delusions","Depressed mood"]
    
    
    
    
    
    
    
    var selectedBodyPart: BodyPartModel?
    var selectedSemptom: SymptomModel?
    
    //popup stuff
    //---------------------------------
    
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var popupTableView: UITableView!
    
    @IBOutlet weak var popupPageNuberLabel: UILabel!
    
    @IBOutlet weak var popupQuestionLabel: UILabel!
    
    //var refineList : [QuestionModel] = [];
    
    var questionsList : [QuestionModel] = [];
    var currentQuestionIndex = 0;
    
    var bodyPartId = 0;
    
    // Data Insturcture
    /* struct Object {
     var  questionName :String!
     var answersList :[(String,Int)]!
     }*/
    //var objectArray = [Object]()
    var nuThislistFromArray = 0
    //var ThislistFromArray :Object?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        popupView.frame.size.width = self.view.frame.size.width
        
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionIndex = 0;
        
        //  self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
        //fix button image color
        let orangecolore = hexStringToUIColor(hex: "F77C12", alpha: 1.0)
        changeColorImageInButton(button: showBodyButton, imageName: "body", color: orangecolore)
        changeColorImageInButton(button: showListButton, imageName: "list", color: .white)
        
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        // search bar design
        searchBar.barTintColor = .white
        
        ///popup Stuf
        //--------------
        popupTableView.delegate = self
        popupTableView.dataSource = self
        
        //objectArray = [Object(questionName: "What is the color of your eye?", answersList: [("gray",0),("pink",1),("transpernt",0),("none of abouve",0)]),Object(questionName: "Do have any pain ?", answersList: [("sharp",0),("wide and warm",0),("on presure",0),("none",0)]),Object(questionName: "What is your pee color ", answersList: [("dark yellow",0),("brown to red",0),("transpernt",0)])]
        // ThislistFromArray = objectArray[0]
        
        popupPageNuberLabel.text = "1/\(questionsList.count)"
        /*
         searchBar.layer.borderColor = UIColor.blue.cgColor
         searchBar.layer.borderWidth = 1
         searchBar.layer.cornerRadius = 3.0
         searchBar.clipsToBounds = true
         */
        
        //curentData = refineList
        
        
        
        // hide keyboard
        //  self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        
        
        // langauge direction
        if(Util.isRTL()){
            showBodyButton.imageEdgeInsets.left = 26
            showListButton.imageEdgeInsets.left = 26
            showBodyButton.imageEdgeInsets.right = 0
            showListButton.imageEdgeInsets.right = 0
        }else{
        }
        if(bodyPartId > 0){
            loadSymptomsById()
        }
        else {
            loadSymptoms()
        }
    }
    
    override func viewWillLayoutSubviews() {
        showBodyButton.roundCorners([.topRight, .bottomRight], radius: 5)
        showListButton.roundCorners([.topLeft, .bottomLeft], radius: 5)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText == "") {
            self.filtered = [];
            self.filtered.append(contentsOf: self.bodyPartsList);
        }
        else {
            //self.filtered = [];
            
            //self.filtered.append(contentsOf: self.bodyPartsList);
            for (i, value) in filtered.enumerated() {
                //filtered[i].symptoms = []
                filtered[i].symptoms = bodyPartsList[i].symptoms.filter({ (text) -> Bool in
                    let tmp: NSString = text.name as NSString;
                    let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                    return range.location != NSNotFound
                });
                
            }
            
            
            
            /* filtered = bodyPartsList.filter({ (text) -> Bool in
             let tmp: NSString = text.title as NSString;
             let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
             return range.location != NSNotFound
             });*/
        }
        self.tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView.tag == 1) {
            return filtered.count
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            if(filtered.count > section) {
                return filtered[section].symptoms.count
            }
        } else {
            if(questionsList.count > currentQuestionIndex) {
                return questionsList[currentQuestionIndex].answers.count
            }
        }
        return 0;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellReturn : UITableViewCell?
        
        if tableView.tag == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for :indexPath) as! ListSemptomsTableViewCell
            cell.nameText.text = filtered[indexPath.section].symptoms[indexPath.row].name
            cellReturn = cell
        }else if tableView.tag == 2 {
            popupQuestionLabel.text = questionsList[currentQuestionIndex].questionBody
            let thisRefineCell = tableView.dequeueReusableCell(withIdentifier: "refineCell" , for :indexPath) as! RefineCellTableViewCell
            thisRefineCell.questionLabel.text = questionsList[currentQuestionIndex].answers[indexPath.row].answerBody
            let thisRadio = questionsList[currentQuestionIndex].answers[indexPath.row].isSelected
            if !thisRadio{
                thisRefineCell.unSelectedRadio()
            }else{
                thisRefineCell.selectedRadio()
            }
            thisRefineCell.radioButton.isEnabled = false
            cellReturn = thisRefineCell
        }
        
        return cellReturn!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 1 {
            print("You selected cell #\(filtered[indexPath.section].symptoms[indexPath.row])!")
            
            
            let selectedPart = BodyPartModel(title: filtered[indexPath.section].title);
            selectedBodyPart = filtered[indexPath.section];
            
            let s = filtered[indexPath.section].symptoms[indexPath.row];
            
            if(s.warning != "") {
                
                
                let appearance = SCLAlertView.SCLAppearance(kTitleFont: Util.getBoldFont(size: 15), kTextFont: Util.getLightFont(size: 15), kButtonFont: Util.getBoldFont(size: 15),showCloseButton: true, contentViewColor: UIColor.curaWhite(), contentViewBorderColor: UIColor.red, titleColor: UIColor.red)
                SCLAlertView(appearance: appearance).showInfo("", subTitle: s.warning, closeButtonTitle:"Done".localized(), colorStyle: UIColor.curaUIntRed() )
            }
            
            
            selectedSemptom = s;
            selectedPart.symptoms.append(s);
            var added = false;
            
            for existSymptom in Util.selectedSymptoms {
                if(existSymptom.title == selectedPart.title) {
                    
                    for sym in existSymptom.symptoms {
                        if(sym.symptomId == filtered[indexPath.section].symptoms[indexPath.row].symptomId) {
                            
                            SCLAlertView(appearance: appearance).showInfo("", subTitle: "You have already added this symptom!".localized(), colorStyle: UIColor.curaUIntBlue());
                            
                            added = true;
                        }
                    }
                    
                    if(!added) {
                        s.questions = []
                        existSymptom.symptoms.append(s)
                        loadQuestions(symId: filtered[indexPath.section].symptoms[indexPath.row].symptomId)
                        added = true;
                    }
                }
            }
            
            if(!added) {
                Util.selectedSymptoms.append(selectedPart);
                loadQuestions(symId: filtered[indexPath.section].symptoms[indexPath.row].symptomId)
            }
            
        } else if tableView.tag == 2 {
            print("You selected cell #\(String(describing: questionsList[currentQuestionIndex].answers[indexPath.row].answerBody))!")
            
            // let thisRefineCell = tableView.cellForRow(at: indexPath) as! RefineCellTableViewCell
            
            //reset all radio to 0
            if(!questionsList[currentQuestionIndex].isMultiple) {
                for index in 0 ... questionsList[currentQuestionIndex].answers.count-1 {
                    questionsList[currentQuestionIndex].answers[index].isSelected = false;
                }
            }
            // assign new select
            questionsList[currentQuestionIndex].answers[indexPath.row].isSelected = true;
            
            tableView.reloadData()
            
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var thisTitleheader = "";
        if tableView.tag == 1{
            
            if(filtered.count > section){
                thisTitleheader = filtered[section].title
            }
        }else if tableView.tag == 2 {
            thisTitleheader = ""
        }
        return thisTitleheader
    }
    
    
    // change section background color
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        
        tableView.backgroundView?.backgroundColor = .white
        tableView.tintColor = .white
        tableView.backgroundColor = .white
        
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = Util.getLightFont(size: 16);
        
        if tableView.tag == 1{
            
        }else if tableView.tag == 2 {
            header.frame.size.height = 0
        }
    }
    
    
    
    
    
    @IBAction func popupNextButtnClicked(_ sender: UIButton) {
        
        let totalNumListQuestions = questionsList.count-1
        let q = questionsList[currentQuestionIndex];
        //Util.selectedSymptoms[0].symptoms[0].questions.append();
        var answers:[AnswerModel] = []
        for a in questionsList[currentQuestionIndex].answers {
            if(a.isSelected) {
                answers.append(a);
            }
        }
        q.answers = answers;
        
        
        
        
        for existSymptom in Util.selectedSymptoms {
            if(existSymptom.title == selectedBodyPart!.title) {
                
                for sym in existSymptom.symptoms {
                    if(sym.symptomId == selectedSemptom!.symptomId) {
                        sym.questions.append(q);
                    }
                }
            }
        }
        
        
        
        
        
        
        if currentQuestionIndex < totalNumListQuestions {
            currentQuestionIndex += 1
            popupPageNuberLabel.text = "\(currentQuestionIndex+1)/\(questionsList.count)"
            popupTableView.reloadData()
            
            
            
        } else {
            performSegue(withIdentifier: "skipPopupMySymproms", sender: self);
        }
    }
    
    @IBAction func popupSkipButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "skipPopupMySymproms", sender: self);
    }
    
    
    
    func loadSymptomsById() {
        
        SwiftLoader.show(animated: true);
        
        //let gender = UserDefaults.standard.object(forKey: "gender") as! String;
        
        let url = ConnectionURLs.getSymptomsUrl(bodyPartId: bodyPartId );
        Alamofire.request(url, headers: Util.getRequestHeaders()).responseJSON { response in
            
            if let itemList = response.result.value as? [NSDictionary] {
                
                if(itemList.count > 0) {
                    
                    self.bodyPartsList = [];
                }
                
                for item in itemList {
                    let sym = BodyPartModel(item: item);
                    let sym2 = BodyPartModel(item: item);
                    self.bodyPartsList.append(sym);
                    self.filtered.append(sym2);
                }
                //self.filtered.append(contentsOf: self.bodyPartsList);
                //self.filtered = self.bodyPartsList.map { $0}
                //self.filtered[0].title = "hi";
                
                self.tableView.reloadData();
                SwiftLoader.hide();
            }
        }
    }
    
    
    func loadSymptoms() {
        
        SwiftLoader.show(animated: true);
        
        let gender = UserDefaults.standard.object(forKey: "gender") as! String;
        
        let url = ConnectionURLs.getSymptomsUrl(gender: gender );
        Alamofire.request(url, headers: Util.getRequestHeaders()).responseJSON { response in
            
            if let itemList = response.result.value as? [NSDictionary] {
                
                if(itemList.count > 0) {
                    
                    self.bodyPartsList = [];
                }
                
                for item in itemList {
                    let sym = BodyPartModel(item: item);
                    let sym2 = BodyPartModel(item: item);
                    self.bodyPartsList.append(sym);
                    self.filtered.append(sym2);
                }
                //self.filtered.append(contentsOf: self.bodyPartsList);
                //self.filtered = self.bodyPartsList.map { $0}
                //self.filtered[0].title = "hi";
                
                self.tableView.reloadData();
                SwiftLoader.hide();
            }
        }
    }
    
    func loadQuestions(symId: Int) {
        SwiftLoader.show(animated: true);
        Alamofire.request(ConnectionURLs.getQuestionsUrl(symId: symId), headers: Util.getRequestHeaders()).responseJSON { response in
            if let itemList = response.result.value as? [NSDictionary] {
                if(itemList.count > 0) {
                    self.questionsList = [];
                }
                for item in itemList {
                    let q = QuestionModel(item: item);
                    self.questionsList.append(q);
                }
                self.popupPageNuberLabel.text = "1/\(self.questionsList.count)"
                self.popupTableView.reloadData();
                self.view.addSubview(self.popupView)
                SwiftLoader.hide();
            }
        }
    }
    
}
