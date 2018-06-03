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

    @IBOutlet weak var exDesc: UITextView!
    @IBOutlet weak var addButtom: UIButton!
    
    
  
   
    var currentUser : User?
    var exercise : Exercise?
    var plan : Plan?
    override func viewDidLoad() {
        
        if plan?.planName == nil {
            
            addButtom.isHidden = true
            
        }
        
        
        
//        ModelNotification.plan.observe { (plan) in
//            self.plan = plan
//            print(self.plan?.planName)
//        }
        
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid
        Model.instance.getUser(uid: uid!, callback: {(user) in
            self.currentUser = user
        })
        
        
        
        
        if let exe = exercise {
        execriseName.text = exe.name
        exDesc.text = exe.execDescription
        let youtubeurl = exe.urlVideo
        print(youtubeurl)
        viewYouTube.allowsInlineMediaPlayback = true
        viewYouTube.loadHTMLString("<iframe width=\"\(viewYouTube.frame.width)\" height=\"\(viewYouTube.frame.height)\" src=\"\(youtubeurl)? &playsline=1\" frameborder=\"0\" gesture=\"media\" allow=\"encrypted-media\" allowfullscreen></iframe>", baseURL: nil)
    
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if plan?.planName == nil {
            
            addButtom.isHidden = true
            
        }
        
    }
    
    
    @IBAction func addExcercise(_ sender: Any) {
        
        
        
        var inputs = [String]()
        if self.currentUser?.myPlans == nil {
                    // Create new exe + new members
                    
                    
                    // save to DB
                    
        }
        else{
                    //self.currentUser
                    
                    let alert = UIAlertController(title: "What's your name?", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                    alert.addTextField(configurationHandler: { textField in
                        textField.placeholder = "Number of sets"
                    })
                    alert.addTextField(configurationHandler: { textField in
                        textField.placeholder = "Number of repeats"
                        
                        print(textField.text)
                        
                    })
                    alert.addTextField(configurationHandler: { textField in
                        textField.placeholder = "Rest time"
                                            })

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        inputs.append (alert.textFields![0].text!)
                        inputs.append (alert.textFields![1].text!)
                        inputs.append (alert.textFields![2].text!)
                        
                        let exercise1 = Exercise(exercise: self.exercise!, numOfSets: inputs[0], numOfRepeats: inputs[1], numOfRestTime: inputs[2])
                        
                        Model.instance.addExerciseToPlan(user: self.currentUser!, planName: (self.plan?.planName)!, exercise: exercise1)
                        
                    }))

                    self.present(alert, animated: true)
                    
                   
                    
                  
                    
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
