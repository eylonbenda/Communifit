//
//  CommentsForPostCell.swift
//  Final_Project
//
//  Created by admin on 26/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CommentsForPostCell: UITableViewCell {


    @IBOutlet weak var commentContent: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
