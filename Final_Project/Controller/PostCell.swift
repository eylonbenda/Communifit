//
//  PostCell.swift
//  Final_Project
//
//  Created by admin on 24/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postContent: UILabel!
    
    
    @IBAction func addComment(_ sender: Any) {
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
