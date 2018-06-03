//
//  SharedPublicPlan.swift
//  Final_Project
//
//  Created by ofir kariv on 6/3/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class SharedPublicPlan {
    
    var id : String?
    var plan : Plan?
    var user : User?
    var likesCount : Int?
    var likesUserSet = Set<String>()
    
    init(id : String , plan : Plan? , user : User? , likesCount : Int?, likesSet : Set<String>) {
        
        self.id = NSUUID().uuidString
        self.plan = plan
        self.user = user
        self.likesCount = likesCount
        self.likesUserSet = likesSet
    }
    
    
    init(fromJson : [String : Any]) {
        
        self.id = NSUUID().uuidString
        self.plan = fromJson["plan"] as? Plan
        self.user = fromJson["user"] as? User
        self.likesCount = fromJson["likesCount"] as? Int
        self.likesUserSet = (fromJson["likesSet"] as? Set<String>)!
    
        }
        
        if fromJson["comments"] != nil{
            let plans  = fromJson["comments"] as! [String: Any]
            for (_, val) in plans {
                let temp = val as! [String:Any]
                let comment = Comment(json: temp)
                comments.append(comment)
            }
        }
        
        
        
        
    }
    
}
