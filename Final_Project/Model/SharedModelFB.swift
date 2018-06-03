//
//  SharedModelFB.swift
//  Final_Project
//
//  Created by ofir kariv on 6/3/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Firebase


class SharedModelFB {
    
    let ref : DatabaseReference?
    
    init() {
        
        ref = Database.database().reference()
        
    }
   
    
}
