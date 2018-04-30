//
//  Users.swift
//  Final_Project
//
//  Created by admin on 03/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//
import Foundation
import FirebaseDatabase


class User {
    
    var uid : String?
    var userName : String?
    var fullName :String?
    var email : String?
    var age: String?
    var hight : String?
    var wight : String?
    var urlImage : String?
    var myPlans = [Plan]()
    var lastUpdate : Date?
    
    
    
    init(uid : String,email: String , userName : String , fullName : String , hight : String , wight : String,urlImage : String?){
        self.email=email
        self.userName = userName
        self.fullName = fullName
        self.hight = hight
        self.wight = wight
        self.uid = uid
        self.urlImage = urlImage
    }
    
    
    init(fromJson : [String:Any]) {
        
        uid = fromJson["uid"] as? String
        userName = fromJson["userName"] as? String
        fullName = fromJson["fullName"] as? String
        email = fromJson["email"] as? String
        hight = fromJson["hight"] as? String
        wight = fromJson["wight"] as? String
        urlImage = fromJson["urlImage"] as? String
        
        if let date = fromJson["lastUpdate"] as? Double{
         self.lastUpdate = Date.fromFirebase(date)
        }
        
        
        if fromJson["myPlans"] != nil{
        let plans  = fromJson["myPlans"] as! [String: Any]
        for (key, val) in plans {
            let temp = val as! [String:Any]
            let plan = Plan(jsonToPlan : temp)
            myPlans.append(plan)
            }
        }
        
        
        
        
    }
    
    //convert execrcise obj to json obj
    func userToJson() -> [String:Any] {
        
        var jsonObj = [String:Any]()
        jsonObj["uid"] = uid
        jsonObj["userName"] = userName
        jsonObj["fullName"] = fullName
        jsonObj["email"] = email
        jsonObj["hight"] = hight
        jsonObj["wight"] = wight
        jsonObj["urlImage"] = urlImage
        jsonObj["lastUpdate"] = ServerValue.timestamp()
//        jsonObj["myPlans"] = myPlanToJson(myPlans: myPlans)
        return jsonObj
        
    }
    
    func convertMyPlanToJson() -> [String:Any]{
        
        var json = [String:Any]()
        json["myPlans"] = myPlanToJson(myPlans: myPlans)
        return json
        
    }
    
    func myPlanToJson(myPlans:[Plan])->[String:Any]
    {
        var map=[String:Any]()
        for  plan in myPlans{
            map[plan.planName!] = plan.planToJson()
        }
        return map
    }
    
    
}
