//  PlansViewController.swift

//  Final_Project

//

//  Created by ofir kariv on 4/30/18.

//  Copyright © 2018 admin. All rights reserved.

//



import UIKit

import Firebase



class PlansViewController: UIViewController ,  UITableViewDelegate , UITableViewDataSource {
    
    
    
    
    
    @IBOutlet weak var plansTable: UITableView!
    
    @IBOutlet weak var input: UITextField!
    
    var currentUser : User?
    
    var planArr = [Plan]()
    
    var plan : Plan?
    
    var row : Int?
    
    
    
    @IBAction func viewExercises(_ sender: Any) {
        
        
        
        performSegue(withIdentifier: "goToExercises", sender: self)
        
        
        
    }
    
    
    
    @IBAction func addPlan(_ sender: Any) {
        
        
        
        if input.text != nil && input.text != "" {
            
            plan = Plan(planName: input.text!)
            
            self.currentUser?.myPlans.append(plan!)
            
            Model.instance.addPlanToUser(user: self.currentUser!)
            
            ModelNotification.plan.post(data: plan!)
            
            performSegue(withIdentifier: "goToExercise", sender: self)
            
        }
            
        else {}
        
        // TODO pormpt alert of empty name
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "goToExercise" {
            
            
            
            let des = segue.destination as? CreateWorkout
            
            des?.plan = self.plan
            
            
            
        } else if segue.identifier == "ViewPlan" {
            
            
            
            let des = segue.destination as? ExercisesPlanTable
            
            des?.plan = self.plan
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (currentUser?.myPlans.count)!
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "planCell", for: indexPath) as! plansViewCell
        
        let plan = currentUser?.myPlans[indexPath.row]
        
        cell.planName.text = plan?.planName
        
        
        
        
        
        return cell
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        row = indexPath.row
        
        plan = currentUser?.myPlans[row!]
        
        performSegue(withIdentifier: "ViewPlan", sender: self)
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        plansTable.delegate = self
        
        plansTable.dataSource = self
        
        //self.plansTable.isEditing=true
        
        
        
        
        
        ModelNotification.planList.observe { (plans) in
            
            
            
            if plans != nil {
                
                self.currentUser?.myPlans = plans!
                
                self.plansTable.reloadData()
                
            }
            
        }
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        Model.instance.getPlans(user: currentUser!)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            //currentUser?.myPlans[indexPath.row]
            
            Model.instance.deletePlanFromUser(user: currentUser!, planName: (currentUser?.myPlans[indexPath.row])!)
            
            currentUser?.myPlans.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            ////////////////////////////////////////////////////////////
            
            
            
        }
        
        
        
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
