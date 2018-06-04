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
    
    init( plan : Plan? , user : User?) {
        
        self.id = NSUUID().uuidString
        
        self.plan = plan
        
        self.user = user
        
        self.likesCount = 0
    }
    
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
        
//        self.likesUserSet = (fromJson["likesSet"] as? Set<String>)!
        
        
        
    }
    
    
    
    
    
    func toJson()-> [String : Any] {
        
        
        
        var jsonObj = [String:Any]()
        
        jsonObj["id"] = id
        
        jsonObj["plan"] = plan?.planToJson()
        
        jsonObj["user"] = user?.userToJson()
        
        jsonObj["likesCount"] = likesCount
        
        
        
        //        jsonObj["myPlans"] = myPlanToJson(myPlans: myPlans)
        
        return jsonObj
        
        
        
        
        
    }
    
    
    
    /*   if fromJson["comments"] != nil{
     
     let plans  = fromJson["comments"] as! [String: Any]
     
     for (_, val) in plans {
     
     let temp = val as! [String:Any]
     
     let comment = Comment(json: temp)
     
     comments.append(comment)
     
     }
     
     }*/
    
    
    
    
    
    
    
    
    
}





