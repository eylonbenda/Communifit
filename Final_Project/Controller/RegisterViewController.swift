//
//  RegisterViewController.swift
//  Final_Project
//
//  Created by Eylon Ben David on 25/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var hight: UITextField!
    @IBOutlet weak var wight: UITextField!
    
    
    var newUser : User?
//    var modelUser : UserModelFirebase?
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        modelUser = UserModelFirebase()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createUser(_ sender: Any) {
        
   
        SVProgressHUD.show()
        
        //check if exsit username like the user entered
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if error != nil {
                
                Utilits.createAlert(viewController: self, title: "Invalid Email/Password.", message: "Please enter new email and password.")
                
                print(error!)
            } else {
                
                let uid = Auth.auth().currentUser?.uid
                self.newUser = User(uid: uid! ,email: self.email.text!, userName: self.userName.text!, fullName: self.fullName.text!, hight: self.hight.text!, wight: self.wight.text!,urlImage : nil)
//                self.modelUser?.addNewUser(user: self.newUser!)
                Model.instance.addUser(user: self.newUser!)
                print("Registration sucsseful!")
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
