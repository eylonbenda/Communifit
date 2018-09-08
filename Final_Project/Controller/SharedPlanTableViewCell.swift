    //
    
    //  SharedPlanTableViewCell.swift
    
    //  Final_Project
    
    //
    
    //  Created by ofir kariv on 6/3/18.
    
    //  Copyright © 2018 admin. All rights reserved.
    
    //
    
    
    
    import UIKit
    
    
    
    class SharedPlanTableViewCell: UITableViewCell {
        
        
        @IBOutlet weak var likesOutlet: UIButton!
        
        @IBOutlet weak var userName: UILabel!
        
        @IBOutlet weak var planName: UILabel!
        
        @IBOutlet weak var userImage: UIImageView!
        
        @IBOutlet weak var likeCounter: UILabel!
        
        var checkHasChanged : Bool = false
        
        
        
        

        
        override func awakeFromNib() {
            
            super.awakeFromNib()
            
            // Initialization code
            
        }
        
        func changeLikeAndChange(){
            if(checkHasChanged == false)
            {
                likeCounter.text = String((Int(likeCounter.text!))!+1)
                checkHasChanged = true
            }
            
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            
            super.setSelected(selected, animated: animated)
            
            
            
            // Configure the view for the selected state
            
        }
        
        
        
    }
