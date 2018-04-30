//
//  ProfileViewController.swift
//  Final_Project
//
//  Created by admin on 04/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ProfileViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var hight: UILabel!
    @IBOutlet weak var wight: UILabel!
    
    var image : UIImage?
 
    
    var currentUser : User?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModelNotification.user.observe { (user) in
            
            self.currentUser = user
            
        }
        
        let uid = Auth.auth().currentUser?.uid
        if uid == nil {
            
            performSegue(withIdentifier: "goToRegister", sender: self)
            
        }else{
        Model.instance.getUser(uid: uid!) { (user) in
            self.currentUser = user
         }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        self.userName.text = self.currentUser?.userName
        self.email.text = self.currentUser?.email
        self.name.text = self.currentUser?.fullName
        self.wight.text = self.currentUser?.wight
        self.hight.text = self.currentUser?.hight
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2.0
        profileImage.layer.masksToBounds = true
        
        if currentUser?.urlImage != nil {
            
            ModelFilesStore.getImage(name:(currentUser?.userName)!, urlStr: (currentUser?.urlImage)!, callback: { (profileImage) in
                self.profileImage.image = profileImage
            })
            
        }
        
    }
    
    func updaeUser(user : User){
        
        self.currentUser = user
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeImage(_ sender: Any) {
        
        if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else if  UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.profileImage.image = image
        self.dismiss(animated: true, completion: nil)
   
        
        
        //save to local and remote DB image-profile
        ModelFilesStore.saveImage(image: image!, name: (currentUser?.userName)!) { (url) in
            //update user in firebase
            print(url!)
            self.currentUser?.urlImage = url
            Model.instance.updateUserImage(user: self.currentUser!)
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
