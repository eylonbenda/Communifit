//
//  UserModelFirebase.swift
//  Final_Project
//
//  Created by admin on 04/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Firebase

class UserModelFirebase  {
    
     let ref : DatabaseReference?
   
    
     init() {
        
        ref = Database.database().reference()
         
    }
    
    
    
    func addNewUser(user : User){
        
        let myRef = ref?.child("Users").child(user.uid!)
        myRef?.setValue(user.userToJson())
        
        
    }
    
    
    func addTrainPlanToUser(user : User){
        
        let myRef = ref?.child("Users").child(user.uid!).child("myPlans")
        myRef?.setValue(user.convertMyPlanToJson())
    }
    
    func addExerciseToPlan(user : User , planName : String, exercise : Exercise){
        
        let myRef = ref?.child("Users").child(user.uid!).child("myPlans").child(planName).child("exercises").child(exercise.name)
        myRef?.setValue(exercise.toJson())
        
    }
    
    
    func getUser(uid : String , callback : @escaping (User?) -> Void){
        
        
         let myRef = ref?.child("Users").child(uid)
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let value = snapshot.value as? [String :  Any] {
                let user = User(fromJson: value)
                callback(user)
            } else {
                callback(nil)
            }
        })
        
        
        
    }
    
    func getAllUsers(callback : @escaping ([User]?)->Void){
        
        let myRef = ref?.child("Users")
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let values = snapshot.value as? [String : [String : Any]] {
                
                var usersArr = [User]()
                for userJson in values{
                    
                    let user = User(fromJson: userJson.value)
                    usersArr.append(user)
                }
                
                callback(usersArr)
                
            } else {
                
                callback(nil)
            }
        })
    }
    
    func getAllUsersAndObserve(lastUpdateDate: Date? ,callback : @escaping ([User]?)->Void){
        
        let handler = {(snapshot:DataSnapshot) in
            
            if let values = snapshot.value as? [String : [String : Any]] {
                var usersArr = [User]()
                for userJson in values{
                    let user = User(fromJson: userJson.value)
                    usersArr.append(user)
                }
                callback(usersArr)
            } else {
                callback(nil)
            }
        }
        
        let myRef = ref?.child("Users")
        
        if (lastUpdateDate != nil){
            print("q starting at:\(lastUpdateDate!) \(lastUpdateDate!.toFirebase())")
            let fbQuery = myRef?.queryOrdered(byChild:"lastUpdate").queryStarting(atValue:lastUpdateDate!.toFirebase())
            fbQuery?.observe(.value, with: handler)
        }else{
            myRef?.observe(.value, with: handler)
        }
      
    }
    
    
    func updateUserImage(user : User  ){
        
        let myRef = ref?.child("Users").child(user.uid!).child("urlImage")
        myRef?.setValue(user.urlImage)
        
        
    }
    
    func removePlanFromUser(user:User,planName:Plan){
        
        let myRef = ref?.child("Users").child(user.uid!).child("myPlans").child(planName.planName!)
        
        myRef?.setValue(nil)
        
    }
    

   
    func getAllPlans (user : User , callback : @escaping ([Plan]?) -> Void) {
        
        let myRef = ref?.child("Users").child(user.uid!).child("myPlans")
        myRef?.observe(.value, with: { (snapshot) in
            
            if let values = snapshot.value as? [String : [String : Any]] {
                var planArr = [Plan]()
                for planJson in values{
                    let plan = Plan(jsonToPlan: planJson.value)
                    planArr.append(plan)
                }
                    callback(planArr)
                }
            else{
            callback(nil)
            }
        })
    }
    
    

    
}
