//
//  ExercisesRepoCellTableViewCell.swift
//  Final_Project
//
//  Created by Eylon Ben David on 31/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ExercisesRepoCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseDescription: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
