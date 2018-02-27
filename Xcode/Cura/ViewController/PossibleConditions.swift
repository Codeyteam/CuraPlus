//
//  PossibleConditions.swift
//  Cura
//
//  Created by Ivan Ghazal on 12/11/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit
import UICircularProgressRing

class PossibleConditions: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var diseasesList : [DiseaseModel] = [];
    var selectedDisease : DiseaseModel!;
    
    //let conditionsList = [("Cold exposure","",78),("Abscess","",72),("West Nile viruse","Floating in your Area ",54),("Floating in your Area ","",7),("Mucopolysaccharidosis (MPS1)","",1),("Mucopolysaccharidosis (MPS2)","",1)]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // clear background
        tableView.backgroundView?.backgroundColor = .clear
        tableView.backgroundColor = .clear
        

    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diseasesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for :indexPath) as! cellPossibleConditions
        cell.conditionName.text = diseasesList[indexPath.row].name
        cell.conditionNote.text = diseasesList[indexPath.row].subCategory
        cell.conditionPersentage.value = CGFloat(diseasesList[indexPath.row].percent)
        //properties
        cell.conditionPersentage.valueIndicator = ""
        cell.conditionPersentage.font = Util.getLightFont(size: 14)
        //animation
       // cell.animateCirculer(thisCircularProgressRing: cell.conditionPersentage, value: 90)
        //cell.conditionPersentage.setProgress(value: 90, animationDuration: 12, completion: nil)
        
        return cell
    }
    
   
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDisease = diseasesList[indexPath.row];
        self.performSegue(withIdentifier: "ShowCondition", sender: self)
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCondition" {
            let vc = segue.destination as! conditionPage
            vc.descriptionTxt = selectedDisease.desc;
            vc.diseaseName = selectedDisease.name;
        }
    }
 

}
