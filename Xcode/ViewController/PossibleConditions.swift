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
    
    
    let conditionsList = [("Cold exposure","",78),("Abscess","",72),("West Nile viruse","Floating in your Area ",54),("Floating in your Area ","",7),("Mucopolysaccharidosis (MPS1)","",1),("Mucopolysaccharidosis (MPS2)","",1)]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // clear background
        tableView.backgroundView?.backgroundColor = .clear
        tableView.backgroundColor = .clear
        

    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conditionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for :indexPath) as! cellPossibleConditions
        cell.conditionName.text = conditionsList[indexPath.row].0
        cell.conditionNote.text = conditionsList[indexPath.row].1
        cell.conditionPersentage.value = CGFloat(conditionsList[indexPath.row].2)
        //properties
        cell.conditionPersentage.valueIndicator = ""
        cell.conditionPersentage.font = UIFont.systemFont(ofSize: 14)
        //animation
       // cell.animateCirculer(thisCircularProgressRing: cell.conditionPersentage, value: 90)
        //cell.conditionPersentage.setProgress(value: 90, animationDuration: 12, completion: nil)
        
        return cell
    }
    
   
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowCondition", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
