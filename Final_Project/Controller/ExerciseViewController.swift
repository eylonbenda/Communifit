//
//  ExerciseViewController.swift
//  Final_Project
//
//  Created by admin on 04/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Firebase

class ExerciseViewController: UIViewController {
    
    @IBOutlet weak var execriseName: UILabel!
    @IBOutlet weak var viewYouTube: UIWebView!
    @IBOutlet weak var exDesc: UILabel!
    
    
  
   
    var currentUser : User?
    var exercise : Exercise?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let exe = exercise {
        execriseName.text = exe.name
        exDesc.text = exe.execDescription
        let youtubeurl = exe.urlVideo
        print(youtubeurl)
        viewYouTube.allowsInlineMediaPlayback = true
        viewYouTube.loadHTMLString("<iframe width=\"\(viewYouTube.frame.width)\" height=\"\(viewYouTube.frame.height)\" src=\"\(youtubeurl)? &playsline=1\" frameborder=\"0\" gesture=\"media\" allow=\"encrypted-media\" allowfullscreen></iframe>", baseURL: nil)
    
        }
    
    }
    
    
    @IBAction func addExcercise(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let uid = Auth.auth().currentUser?.uid
            Model.instance.getUser(uid: uid!, callback: { (user) in
                self.currentUser = user
                if self.currentUser?.myPlans == nil {
                    //TODO : 1) Create list of plans
                    //TODO : 2) Add excerise to the plan created
                    Model.instance.addPlanToUser(user: self.currentUser!)
                }
                else{
                    /* TODO:
                     ask user if he wants to use the current plan
                     if true :
                     Choose plan
                     Add excerise to the plan
                     else
                     create plan
                     Add excerise to the plan created
                     
                     */
                }
                
            })
            
        } else {
          
            performSegue(withIdentifier: "goToAuth", sender: self)
            
        }
        
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
