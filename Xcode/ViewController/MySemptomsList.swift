//
//  MySemptomsList.swift
//  Cura
//
//  Created by Ivan Ghazal on 12/2/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit
import Localize_Swift

class MySemptomsList: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var showBodyButton: UIButton!
    
    @IBOutlet weak var showListButton: UIButton!
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    // array data
    var searchActive : Bool = false
    var section = ["Head"]
    var data = ["Agitation".localized(),"Anxiety".localized(),"Apathy","Bald spot (Hair)","Blackouts".localized(),"Bleeding","Seattle","Brittle Hair","Broken Bone","Coma","Compulsive behavior","Confusion","Craving alchohol","Craving to eat ice , dirt or paper","Crawling sensation","Delusions","Depressed mood"]
    
    
    var filtered:[String] = []
    
    
    //popup stuff
    //---------------------------------
    
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var popupTableView: UITableView!
    
    @IBOutlet weak var popupPageNuberLabel: UILabel!
    
    @IBOutlet weak var popupQuestionLabel: UILabel!
    
    var refineList = ["first questions about " , "second question about other second question about othe rsecond question about other" , "none of abouve" ]
    
    var refineList2 = ["22first questions about " , "2second question about other second question about othe rsecond question about other" , "2none of abouve" ]
    var curentData = [String]()
    
    
    
    // Data Insturcture
    struct Object {
        var  questionName :String!
        var answersList :[(String,Int)]!
    }
    var objectArray = [Object]()
    var nuThislistFromArray = 0
    var ThislistFromArray :Object?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //remove topmenu and footer
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
        //fix button image color
        let orangecolore = hexStringToUIColor(hex: "F77C12", alpha: 1.0)
        changeColorImageInButton(button: showBodyButton, imageName: "body", color: orangecolore)
        changeColorImageInButton(button: showListButton, imageName: "list", color: .white)
        showBodyButton.layer.cornerRadius = 5
        showBodyButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        showListButton.layer.cornerRadius = 5
        showListButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        
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
        
        objectArray = [Object(questionName: "What is the color of your eye?", answersList: [("gray",0),("pink",1),("transpernt",0),("none of abouve",0)]),Object(questionName: "Do have any pain ?", answersList: [("sharp",0),("wide and warm",0),("on presure",0),("none",0)]),Object(questionName: "What is your pee color ", answersList: [("dark yellow",0),("brown to red",0),("transpernt",0)])]
        ThislistFromArray = objectArray[0]
        
        popupPageNuberLabel.text = "1/\(objectArray.count)"
       /*
        searchBar.layer.borderColor = UIColor.blue.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 3.0
        searchBar.clipsToBounds = true
        */
        
        curentData = refineList
        
        
        
        // hide keyboard
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        
        
        // langauge direction
        if(Helper.isRTL()){
            showBodyButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            showListButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            showBodyButton.imageEdgeInsets.left = 26
            showListButton.imageEdgeInsets.left = 26
            showBodyButton.imageEdgeInsets.right = 0
            showListButton.imageEdgeInsets.right = 0
        }else{
            showBodyButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            showListButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        
        
    }
    
    // hide keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
        // do aditional stuff
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var thisReturn :Int?
        if tableView.tag == 1 {
        thisReturn = 1
        }else if tableView.tag == 2 {
            thisReturn =  1
        }
        return thisReturn!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        var thisCount: Int?
        
        if tableView.tag == 1 {
            if(searchActive) {
                return filtered.count
            }
            thisCount =  data.count
            
        }else if tableView.tag == 2 {
            thisCount = ThislistFromArray?.answersList.count
        }
        
        return thisCount!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellReturn : UITableViewCell?
        
        if tableView.tag == 1 {
        
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for :indexPath) as! ListSemptomsTableViewCell
            
                if(searchActive){
                    cell.nameText.text = filtered[indexPath.row]
                    
                } else {
                    cell.nameText.text = data[indexPath.row];
                }
            cellReturn = cell
            
        }else if tableView.tag == 2 {
            popupQuestionLabel.text = ThislistFromArray?.questionName
            let thisRefineCell = tableView.dequeueReusableCell(withIdentifier: "refineCell" , for :indexPath) as! RefineCellTableViewCell
                thisRefineCell.questionLabel.text = ThislistFromArray?.answersList[indexPath.row].0
                let thisRadio = ThislistFromArray?.answersList[indexPath.row].1
            if thisRadio == 0{
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
        
        if tableView.tag == 1{
        print("You selected cell #\(data[indexPath.row])!")
        self.view.addSubview(popupView)

        } else if tableView.tag == 2 {
            print("You selected cell #\(String(describing: ThislistFromArray!.answersList[indexPath.row].0))!")
            
           // let thisRefineCell = tableView.cellForRow(at: indexPath) as! RefineCellTableViewCell
            
            //reset all radio to 0
            for index in 0 ... (ThislistFromArray?.answersList.count)!-1{
                ThislistFromArray?.answersList[index].1 = 0
            }
            // assign new select
            ThislistFromArray?.answersList[indexPath.row].1 = 1
            
            tableView.reloadData()
            

        }
        
        
    }
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var thisTitleheader :String?
         if tableView.tag == 1{
                thisTitleheader = "Head"
            }else if tableView.tag == 2 {
           thisTitleheader = ""
        }
        return thisTitleheader!
    }
 
      
    // change section background color
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        
        tableView.backgroundView?.backgroundColor = .white
        tableView.tintColor = .white
        tableView.backgroundColor = .white
        
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont(name: "Avenir", size: 16.0 )
       
        if tableView.tag == 1{

        }else if tableView.tag == 2 {
            header.frame.size.height = 0
        }
    }

    
 
    

    @IBAction func popupNextButtnClicked(_ sender: UIButton) {
        
        let totalNumListQuestions = objectArray.count-1
        
        if nuThislistFromArray < totalNumListQuestions {
            nuThislistFromArray += 1
            ThislistFromArray = objectArray[nuThislistFromArray]
            popupPageNuberLabel.text = "\(nuThislistFromArray+1)/\(objectArray.count)"
        popupTableView.reloadData()
        } else {
            print("Done")
            
        }
    
    }
    
    @IBAction func popupSkipButtonClicked(_ sender: UIButton) {
        
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
