//
//  MuscleGroupCell.swift
//  Final_Project
//
//  Created by admin on 28/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class MuscleGroupCell: UITableViewCell {

    @IBOutlet weak var groupMuscleName: UILabel!
    @IBOutlet weak var groupMuscleImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
