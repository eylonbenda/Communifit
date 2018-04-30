//
//  NewsFeedTableVC.swift
//  Final_Project
//
//  Created by admin on 24/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class NewsFeedTableVC: UITableViewController {

    var posts = [Post]()
    var currentUser : User?
    
    
    struct storyBoard {
        
        static let postCell = "PostCell"
        static let postHeaderCell = "PostHeaderCell"
        static let postHeaderHight : CGFloat = 57.0
        static let postCellDefalutHeight : CGFloat = 578.0
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = storyBoard.postCellDefalutHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clear
        
        ModelNotification.postList.observe { (listPosts) in
            
            if listPosts != nil {
                
                self.posts = listPosts!
                self.tableView.reloadData()
            }
        }
        
        Model.instance.getAllPostsAndObserve()
    }
    
    
    deinit {
        ModelNotification.removeObserver(observer: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if Auth.auth().currentUser != nil {
           let uid = Auth.auth().currentUser?.uid
            Model.instance.getUser(uid: uid!, callback: { (user) in
                self.currentUser = user
            })
            
        } else {
            
            performSegue(withIdentifier: "goToAuth", sender: self)
            
        }
    }

    @IBAction func uploadPost(_ sender: Any) {
        
         performSegue(withIdentifier: "addPostSegue" , sender: self)
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return posts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyBoard.postCell, for: indexPath) as! PostCell
        
        var post = posts[indexPath.row]
        cell.postContent.text = post.description
        
        if post.urlImage != nil {
            ModelFilesStore.getImage(name: post.description!, urlStr: post.urlImage!, callback: { (image) in
                cell.postImage.image = image
            })
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: storyBoard.postHeaderCell) as! PostHeaderCell
        var post = posts[section]
        cell.author.text = post.author
        cell.backgroundColor = UIColor.white
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return storyBoard.postHeaderHight
    }

}
