//
//  ExercisesPlanTable.swift
//  Final_Project
//
//  Created by ofir kariv on 5/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ExercisesPlanTable: UITableViewController {

    
    var plan : Plan?
    var exer : Exercise?
    var currentExe : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight =  UITableViewAutomaticDimension
        
        print(plan?.planName)

      
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (plan?.exercises.count)!
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentExe = indexPath.row
        exer = plan?.exercises[indexPath.row]
        performSegue(withIdentifier: "showExercise", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showExercise"  {
            let destVC = segue.destination as? ExerciseInPlanViewController
            destVC?.exerciseArr = (plan?.exercises)!
            destVC?.exercise = exer
            destVC?.currentExe = currentExe
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! ExercisePlanTableCell

        exer  = plan?.exercises[indexPath.row]
        cell.exercisePlan.text = exer?.name
        
        if exer?.urlImage != nil {
        
            ModelFilesStore.getImage(name: "exercisesImages/"+(exer?.name)!+".png", urlStr: (exer?.urlImage)!) { (image) in
                
                cell.exerciseImage.image = image
                
            }
        
    }
        
        // Configure the cell...

        return cell
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
