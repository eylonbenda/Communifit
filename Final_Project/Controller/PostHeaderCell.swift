//
//  PostHeaderCell.swift
//  Final_Project
//
//  Created by admin on 24/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
