//
//  WorkoutsVC.swift
//  Final_Project
//
//  Created by admin on 28/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class WorkoutsVC: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Workouts(_ sender: Any) {
        
        
    }
    
    @IBAction func createWorkout(_ sender: Any) {
        
        performSegue(withIdentifier: "CreateNewWorkout", sender: self)
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
