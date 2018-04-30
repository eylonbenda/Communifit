//
//  CreateWorkout.swift
//  Final_Project
//
//  Created by admin on 28/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class CreateWorkout: UITableViewController {
    
    var model : ExerciseModelFirebase?
    @IBOutlet var tableMuscle: UITableView!
    
    var row : Int = 0
    var muscleGroups = [MuscleGroup]()
    var images = [UIImage(named: "chest"), UIImage(named: "abs"), UIImage(named: "legs"), UIImage(named: "biceps"), UIImage(named: "back")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = ExerciseModelFirebase()
        
        // insert muscle-group array data
        insertData(&muscleGroups)
        
        configureTableView()
        tableMuscle.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func insertData(_ muscles : inout [MuscleGroup]){
        
        let chestMuscle = MuscleGroup()
        chestMuscle.name = "Chest"
        muscles.append(chestMuscle)
        
        let absMuscle = MuscleGroup()
        absMuscle.name = "ABS&Core"
        muscles.append(absMuscle)
        
        let legsMuscle = MuscleGroup()
        legsMuscle.name = "Lower-Body"
        muscles.append(legsMuscle)
        
        let armsShoulders = MuscleGroup()
        armsShoulders.name = "Arms&Shoudlers"
        muscles.append(armsShoulders)
        
        let backMuscle = MuscleGroup()
        backMuscle.name = "Back"
        muscles.append(backMuscle)
        
        
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
        return muscleGroups.count
    }
    
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "muscle_group_cell", for: indexPath) as! MuscleGroupCell
        
        cell.groupMuscleName.text = muscleGroups[indexPath.row].name
        cell.groupMuscleImage.image = images[indexPath.row]
    
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         row  = indexPath.row
        print("row \(indexPath.row) was selected")
        performSegue(withIdentifier: "showExercises", sender: self)
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showExercises"  {

            let des = segue.destination as! ExercisesRepoTableViewController
            des.loadViewIfNeeded()

            if row == 0 {
                //load from firebase chest-exercises
                model?.getAllChestExercises(callback: { (exercises) in
                    
                    if let exes = exercises {
                        
                        self.muscleGroups[0].exercises = exes
                        
                    }
                })
                des.muscleGroupExercises = muscleGroups[0]

            } else if row == 1 {
                des.muscleGroupExercises = muscleGroups[1]

            } else if row == 2 {
                des.muscleGroupExercises = muscleGroups[2]
                
            } else if row == 3 {
                des.muscleGroupExercises = muscleGroups[3]
                
            } else if row == 4 {
                des.muscleGroupExercises = muscleGroups[4]
            }
        
            
            
    }
            
        
        
    }
    
    func configureTableView(){
        
        tableMuscle.estimatedRowHeight = 120.0
        tableMuscle.rowHeight =  UITableViewAutomaticDimension
        
        
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
