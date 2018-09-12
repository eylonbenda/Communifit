//
//  AddPostVC.swift
//  Final_Project
//
//  Created by Eylon Ben David on 25/02/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import MobileCoreServices
import AVKit
import AVFoundation


protocol RecievePost {
    
    func getPost(newPost : Post)
    
}



class AddPostVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var postDesc: UITextView!
    var videoURL: URL?
    var player : AVPlayer? = nil
    var playerLayer : AVPlayerLayer? = nil
    

    var delegate : RecievePost?
    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let uid = Auth.auth().currentUser?.uid
        Model.instance.getUser(uid: uid!) { (user) in
            self.currentUser = user
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func takePhoto(_ sender: Any) {
        
        if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.mediaTypes = ["public.movie" , "public.image"]
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
        
        videoURL = info[UIImagePickerControllerMediaURL] as? URL
        print("videoURL:\(String(describing: videoURL))")
        image.image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.dismiss(animated: true, completion: nil)
        for type in picker.mediaTypes{
            if (type == "public.movie"){
                player = AVPlayer(url: videoURL!)
                playerLayer = AVPlayerLayer(player: player)
                playerLayer?.frame = self.view.bounds
                self.view.layer.addSublayer(playerLayer!)
                player?.play()
            }}
        /*
         
         let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
         let player = AVPlayer(url: videoURL!)
         let playerLayer = AVPlayerLayer(player: player)
         playerLayer.frame = self.view.bounds
         self.view.layer.addSublayer(playerLayer)
         player.play()
         
         */
        
        
    }
    
    @IBAction func uploadPost(_ sender: Any) {
        
        var post : Post?
        //save  post to fb and local db
        
        if player != nil
        {
            
            
        }
        ModelFilesStore.saveImage(image: image.image!, name: postDesc.text ) { (url) in
            
            if url != nil{
             post = Post(urlImage: url!, description: self.postDesc.text , author: self.currentUser?.userName )
                Model.instance.addPost(post: post!)
            }
            
           
            
        }
        delegate?.getPost(newPost: post!)
        
        self.navigationController?.popViewController(animated: true)
        
        
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
