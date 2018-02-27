//
//  ChoosenSemptomsViewController.swift
//  Cura
//
//  Created by Ivan Ghazal on 12/7/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit
import Alamofire

class ChoosenSemptomsViewController: BaseVC  , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var showResultButton: buttonShadow!
    
    @IBOutlet weak var mySymptomsTableView: UITableView!
    
    @IBOutlet var popupFrame: UIView!
    @IBOutlet weak var youButton: UIButton!
    
    @IBOutlet weak var lblGender: layerShadow!
    
    
    @IBOutlet weak var lblGender2: UILabel!
    
    @IBOutlet weak var lblAge: UILabel!
    
    var diseasesList : [DiseaseModel] = [];
    
    //var sections = ["Head","Neck"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let age =  UserDefaults.standard.value(forKey: "age") as? String {
            lblAge.text = age
        }
        if let gender = UserDefaults.standard.value(forKey: "gender") as? String{
            if gender == "0" {
                lblGender2.text = "Female".localized()
            }
            else {
                lblGender2.text = "Male".localized()
            }
        }
        
        // Do any additional setup after loading the view.
        
        //Show topmenu and footer
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = " "
        
        self.navigationItem.rightBarButtonItem?.image? = (UIImage(named: "user")?.withRenderingMode(.alwaysOriginal))!
        self.navigationItem.leftBarButtonItem?.image? = (UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal))!
        
        //buttonArrow.tintColor = .white
        
        
        // mySymptomsTableView
        mySymptomsTableView.delegate = self
        mySymptomsTableView.dataSource = self
        
        mySymptomsTableView.backgroundView?.backgroundColor = .clear
        mySymptomsTableView.backgroundColor = .clear
        
        mySymptomsTableView.sectionFooterHeight = 40
        //tableView.sectionHeaderHeight = 120
        
        changeColorImageInButton(button: showResultButton, imageName: "arrow_right", color: .white)

        
        mySymptomsTableView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        mySymptomsTableView.layer.shadowOpacity = 1
        mySymptomsTableView.layer.shadowOffset = CGSize(width: 2, height: 0)
        mySymptomsTableView.layer.shadowRadius = 2

        // langauge direction
        if(Util.isRTL()){
            youButton.titleEdgeInsets.left = 0
            youButton.titleEdgeInsets.right = 7
            youButton.imageEdgeInsets.right = 0
            youButton.imageEdgeInsets.left = 7
            showResultButton.imageEdgeInsets.left = 0
            showResultButton.imageEdgeInsets.right = 270
        }else{
           
        }
        
        
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Util.selectedSymptoms[section].symptoms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mySymptomsTableView.dequeueReusableCell(withIdentifier: "cellMySymptoms" , for :indexPath) as! ChoosenSemptomsCell
       
        cell.nameLabel.text = Util.selectedSymptoms[indexPath.section].symptoms[indexPath.row].name;
        
        if indexPath.row == 2{
            cell.lineImageView.isHidden = true
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Util.selectedSymptoms.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return Util.selectedSymptoms[section].title
    }
  
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Bundle the footer with XIB
        let headerCell = Bundle.main.loadNibNamed("TableCellTop", owner: self, options: nil)?.first as! TableCellTop
        headerCell.labelName.text = Util.selectedSymptoms[section].title
        return headerCell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        // Bundle the footer with XIB
        let footerCell = Bundle.main.loadNibNamed("TableCellBottom", owner: self, options: nil)?.first as! TableCellBottom
        
        return footerCell
    }
    
    
    @IBAction func showDiseases(_ sender: UIButton) {
       
        
        do {
            let data = try JSONEncoder().encode(Util.selectedSymptoms);
             let str = data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            //if let str = String.init(data: data, encoding: .utf8) {
                loadDiseases(json: str);
        }
        catch {
            
            
        }
    }
    
    
    
    
    
    @IBAction func editProfileClicked(_ sender: UIButton) {
        popupFrame.frame = CGRect(x: 0, y: 0, width: self.view.frame.width-48, height: 320)
        openPopup(thisUIView: popupFrame )
    }
    
    
    
    @IBAction func popupOkClicked(_ sender: UIButton) {
        
        closePopup(thisUIView: popupFrame)
    }
    
    func loadDiseases(json: String) {
        
        
        
        SwiftLoader.show(animated: true);
        
        let gender = UserDefaults.standard.object(forKey: "gender") as! String;
        
        let url = ConnectionURLs.getDiseasesUrl();
       // debugPrint(url)
        let params : Parameters =  [
            "ID": json,
            "Gender": gender
        ]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: Util.getRequestHeaders()).responseJSON { response in
            
            //debugPrint(response.result.value);
            
            if let itemList = response.result.value as? [NSDictionary] {
                if(itemList.count > 0) {
                    self.diseasesList = [];
                }
                for item in itemList {
                    let d = DiseaseModel(item: item);
                    self.diseasesList.append(d);
                }
                
                
                self.performSegue(withIdentifier: "ShowResultSegue", sender: self);
                
            }
            SwiftLoader.hide();
        }
        
      
      //  Alamofire.request(url, headers: Util.getRequestHeaders()).responseJSON { response in
            
          
           //     SwiftLoader.hide();
            
     //  }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowResultSegue") {
            let vc = segue.destination as! PossibleConditions
            vc.diseasesList = self.diseasesList
        }
    }

}
