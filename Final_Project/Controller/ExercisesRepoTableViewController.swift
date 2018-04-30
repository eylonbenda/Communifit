//
//  ExercisesRepoTableViewController.swift
//  Final_Project
//
//  Created by Eylon Ben David on 31/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ExercisesRepoTableViewController: UITableViewController {
    
    @IBOutlet var exercisesTable: UITableView!
    
    var exercise : Exercise?
    var row : Int = 0
    var muscleGroupExercises = MuscleGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        exercisesTable.reloadData()
       
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return muscleGroupExercises.exercises.count
    }
    
    
  

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exercise_cell", for: indexPath) as! ExercisesRepoCellTableViewCell
         exercise = muscleGroupExercises.exercises[indexPath.row]
        
        if muscleGroupExercises.name == "Chest" {
         
            let url = NSURL(string: (exercise?.urlImage)!)
            
            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error!)
                }
                
                DispatchQueue.main.async(execute: {
                    cell.exerciseImage.image = UIImage(data: data!)
                    cell.exerciseDescription.text = self.exercise?.name
                })
                
            }).resume()
            
           
            
        } else if muscleGroupExercises.name == "ABS&Core" {
            
           
            
            
        }
        
        

        return cell
    }
    
    
    func configureTableView(){
        
        exercisesTable.estimatedRowHeight = 120.0
        exercisesTable.rowHeight =  UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        row = indexPath.row
        performSegue(withIdentifier: "showExercise", sender: self)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showExercise" {
            
            let des =  segue.destination as! ExerciseViewController
            des.exercise = exercise
            
        }
        
        
        
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
