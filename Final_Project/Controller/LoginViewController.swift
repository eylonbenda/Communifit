//
//  LoginViewController.swift
//  Final_Project
//
//  Created by Eylon Ben David on 25/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

protocol LoginUser {
    func notifyUserConncted(user : User)
}

class LoginViewController: UIViewController  {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var delegate : LoginUser?
    var currentUser : User?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPress(_ sender: Any) {
        
       SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if error != nil {
                
                Utilits.createAlert(viewController: self, title: "Incorrect Password/Email", message: "The password you entered is incorrect. please try again.")
                SVProgressHUD.dismiss()
                print(error!)
                
            } else {
                
                let uid = Auth.auth().currentUser?.uid
                Model.instance.getUser(uid: uid!, callback: { (user) in
                    self.currentUser = user
                  ModelNotification.user.post(data: self.currentUser!)
                })
                
               self.dismiss(animated: true, completion: nil)
                SVProgressHUD.dismiss()
            }
            	
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
