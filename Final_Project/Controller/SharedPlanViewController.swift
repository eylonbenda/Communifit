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
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        let sharedPlan = sharedPlans[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sharedPlan", for: indexPath) as! SharedPlanTableViewCell
        
        
       
        cell.planName.text = sharedPlan.plan?.planName
        
        cell.userName.text = sharedPlan.user?.userName
        
        
        
        //        ModelFilesStore.getImage(name: <#T##String#>, urlStr: <#T##String#>, callback: <#T##(UIImage?) -> Void#>)
        
        
        
        
        
        
        
        return cell
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        table.dataSource = self
        
        table.delegate = self
        
        configureTableView()
        
        
        ModelNotification.sharedPlanList.observe { (sharedPlan) in
            
            
            
            if sharedPlan != nil {
                
                
                
                self.sharedPlans = sharedPlan!
                
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
   
    
    
    
    /*
     
     // MARK: - Navigation
     
     
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     // Get the new view controller using segue.destinationViewController.
     
     // Pass the selected object to the new view controller.
     
     }
     
     */
    
    
    
}


