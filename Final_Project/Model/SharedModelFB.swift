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
    
    func addPlan(pubPlan : SharedPublicPlan){
        
        let myRef = ref?.child("Shared").child(user.uid!).child("Plans")
        // add name of author
        // add counter for likes
        // add set of users who likes
        myRef?.setValue(user.convertMyPlanToJson())
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
