//
//  CommentsForPost.swift
//  Final_Project
//
//  Created by admin on 26/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CommentsForPost: UITableViewController {

    var commmentsList = [Comment]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 65.0
        tableView.rowHeight =  UITableViewAutomaticDimension

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
        return commmentsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentsForPostCell", for: indexPath) as! CommentsForPostCell
        let comment = commmentsList[indexPath.row]
        cell.userName.text = comment.author
        cell.commentContent.text = comment.content
        

        return cell
    }
 
 

}
