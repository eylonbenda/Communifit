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
    
    
    @IBAction func addPlan(_ sender: Any) {
        
        let plan = Plan(planName: input.text!)
        let uid = Auth.auth().currentUser?.uid
        Model.instance.getUser(uid: uid!) { (user) in
            self.currentUser = user
            self.currentUser?.myPlans.append(plan)
            Model.instance.addPlanToUser(user: self.currentUser!)
        }
        
       
        
        
        performSegue(withIdentifier: "goToExercise", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "planCell", for: indexPath) as! plansViewCell
        
        return cell
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
