	//
//  FeedTable.swift
//  Final_Project
//
//  Created by admin on 04/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD



class FeedTable: UITableViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , RecievePost,RecieveUserConnected {
    
   
    @IBOutlet var feedTable: UITableView!

    var users = [User]()
    var listPosts = [Post]()
    var comments=[Comment]()
    var post : Post?
    var currentUser : User?
    var rowIndex : Int = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        configureTableView()
        
        ModelNotification.postList.observe { (posts) in
            
            if posts != nil {
                
                self.listPosts = posts!
                self.feedTable.reloadData()
            }
        }
        
        Model.instance.getAllPostsAndObserve()
        
        
    }
    
    deinit {
        ModelNotification.removeObserver(observer: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if Auth.auth().currentUser != nil {
            // User is signed in.
            let uid = Auth.auth().currentUser?.uid
            Model.instance.getUser(uid: uid!, callback: { (user) in
                self.currentUser = user
            })
           
            
        } else {
            
            performSegue(withIdentifier: "goToAuth", sender: self)
            
            
        }
    }

    func updateUserConnected(user : User){
        
        self.currentUser = user
        
    }
    
    @IBAction func addComment(_ sender: UIButton) {
        
       self.post = listPosts[sender.tag]
        performSegue(withIdentifier: "goToComments", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goToComments" {

            let desVC = segue.destination as! CommentsForPostViewController
            desVC.post = post
            desVC.currentUser = self.currentUser

        }


    }
    
    @IBAction func LogOutPress(_ sender: Any) {
        
        SVProgressHUD.show()
        
        do {
            try Auth.auth().signOut()
            print("sighned out!")
            //self.dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "goToAuth", sender: self)
            SVProgressHUD.dismiss()
            
        }
        catch {
            print("error login out")
            SVProgressHUD.dismiss()
        }
        
        
    }

    @IBAction func uploadPost(_ sender: Any) {
        
        performSegue(withIdentifier: "addPostSegue" , sender: self)
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listPosts.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        rowIndex = indexPath.row
        print("row \(indexPath.row) was selected")
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feed_cell", for: indexPath) as! FeedTableViewCell
        
         let post = listPosts[indexPath.row]
        
        cell.commentButtom.tag = indexPath.row
        cell.commentButtom.addTarget(self, action: #selector(FeedTable.addComment(_:)) , for: .touchUpInside)
        cell.userName.text = post.author
        cell.authorImage.layer.cornerRadius = cell.authorImage.bounds.width / 2.0
        cell.authorImage.layer.masksToBounds = true
        cell.postDes.text = post.description
        
        if post.urlImage != nil {
        
            ModelFilesStore.getImage(name: (post.description!), urlStr: (post.urlImage!), callback: { (image) in
                cell.imageCell.image = image
                
            })
            
        }
        
        return cell
    }
    
   func getPost(newPost: Post) {
    
        listPosts.append(newPost)
        
        
    }
    
    func configureTableView(){
        
        feedTable.estimatedRowHeight = 570.0
        feedTable.rowHeight =  UITableViewAutomaticDimension
        
        
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 570.0
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
