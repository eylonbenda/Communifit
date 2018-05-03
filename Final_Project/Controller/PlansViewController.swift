//
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
    
    @IBAction func viewExercises(_ sender: Any) {
        
        performSegue(withIdentifier: "goToExercises", sender: self)
        
    }
    
    @IBAction func addPlan(_ sender: Any) {
        
        if input.text != nil && input.text != "" {
        let plan = Plan(planName: input.text!)
        self.currentUser?.myPlans.append(plan)
        Model.instance.addPlanToUser(user: self.currentUser!)
        performSegue(withIdentifier: "goToExercise", sender: self)
        }
        else {}
        // TODO pormpt alert of empty name
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
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plansTable.delegate = self
        plansTable.dataSource = self
        
        //TODO : oberve user when a new user have connected
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
