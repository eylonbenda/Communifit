//
//  plansViewCell.swift
//  Final_Project
//
//  Created by ofir kariv on 4/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class plansViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var planImage: UIImageView!
    @IBOutlet weak var planName: UILabel!
    
    @IBOutlet weak var shareButtom: UIButton!
    
    @IBAction func editPlan(_ sender: Any) {
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
