//
//  ExercisePlanTableCell.swift
//  Final_Project
//
//  Created by ofir kariv on 5/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ExercisePlanTableCell: UITableViewCell {

    @IBOutlet weak var exercisePlan: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
