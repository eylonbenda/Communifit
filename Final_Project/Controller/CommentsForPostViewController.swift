//
//  CommentsForPostViewController.swift
//  Final_Project
//
//  Created by admin on 27/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CommentsForPostViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var input: UITextField!
    var commmentsList = [Comment]()
    var currentUser : User?
    var post : Post?
    
    @IBOutlet weak var commentsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (post?.comments.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentsForPostCell", for: indexPath) as! CommentsForPostCell
        let comment = self.post?.comments[indexPath.row]
        cell.userName.text = comment?.author
        cell.commentContent.text = comment?.content
        cell.imageUser.layer.cornerRadius = cell.imageUser.bounds.width / 2.0
        cell.imageUser.layer.masksToBounds = true
        
        return cell
        
    }
    
    @IBAction func addComment(_ sender: Any) {
        
        let comment = Comment(content: input.text!, author: (currentUser?.userName)!)
        post?.comments.append(comment)
        Model.instance.addCommentToPost(post: post!)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTable.delegate = self
        commentsTable.dataSource = self

        commentsTable.estimatedRowHeight = 65.0
        commentsTable.rowHeight =  UITableViewAutomaticDimension
        
        ModelNotification.commentsList.observe { (comments) in
            if comments != nil{
                self.post?.comments = comments!
               self.commentsTable.reloadData()
                
            }
        }
        
        Model.instance.getAllCommentsOfPost(post: self.post!)
        
//        Model.instance.getPostById(post: post!) { (post) in
//            if post != nil {
//            self.post = post
//            self.commentsTable.reloadData()
//        }
//    }
        
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
