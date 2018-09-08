//

//  SharedPlanViewController.swift

//  Final_Project

//

//  Created by ofir kariv on 6/3/18.

//  Copyright © 2018 admin. All rights reserved.

//



import UIKit



class SharedPlanViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    
    
    
    @IBOutlet weak var table: UITableView!
    
    
    var planUser : Plan?
    var row : Int?
    var plan : SharedPublicPlan?
    var sharedPlans = [SharedPublicPlan]()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sharedPlans.count
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if plan != nil {
            
            sharedPlans.append(plan!)
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func likeClicked(_ sender: UIButton) {
       
     
        Model.instance.updateLikes(sharedPlan: sharedPlans[sender.tag])
    }
    
    func getPlanByRow (index: Int){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sharedPlan = sharedPlans[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sharedPlan", for: indexPath) as! SharedPlanTableViewCell

        cell.planName.text = sharedPlan.plan?.planName
        cell.userName.text = sharedPlan.user?.userName
        cell.likeCounter.text = String(sharedPlan.likesCount!)
        cell.likesOutlet.tag = indexPath.row
        cell.likesOutlet.addTarget(self, action: #selector(SharedPlanViewController.likeClicked(_:)) , for: .touchUpInside)
       
        return cell

    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        //table.allowsSelectionDuringEditing = true
        configureTableView()
        ModelNotification.sharedPlanList.observe { (sharedPlan) in
        if sharedPlan != nil {
            self.sharedPlans = sharedPlan!
            self.sharedPlans = (sharedPlan?.sorted(by: { (sharedPlan1, sharedPlan2) -> Bool in
                return sharedPlan1.likesCount! > sharedPlan2.likesCount!
            }))!
            self.table.reloadData()
            }
        }
        Model.instance.getAllSharedPlans()
  
        // Do any additional setup after loading the view.
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    func configureTableView(){
        table.estimatedRowHeight = 72.0
        table.rowHeight =  UITableViewAutomaticDimension
        
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "sharedToExercises" {
            let des = segue.destination as? ExercisesPlanTable
            des?.plan = planUser
        
    }
    }
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        row = indexPath.row
        planUser = sharedPlans[row!].plan
        performSegue(withIdentifier: "sharedToExercises", sender: self)
    
        
    }
    
}


