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
        
        
        
        let myRef = ref?.child("Shared").child(pubPlan.id!)
        
        
        
        myRef?.setValue(pubPlan.toJson())
        
    }
    
    
    
    
    
    func getAllPlans (pubPlan : SharedPublicPlan , callback : @escaping ([SharedPublicPlan]?) -> Void) {
        
        
        
        let myRef = ref?.child("Shared").child(pubPlan.id!)
        
        myRef?.observe(.value, with: { (snapshot) in
            
            
            
            if let values = snapshot.value as? [String : [String : Any]] {
                
                var planArr = [SharedPublicPlan]()
                
                for planJson in values{
                    
                    let sharedPlan = SharedPublicPlan(fromJson: planJson.value)
                    
                    planArr.append(sharedPlan)
                    
                }
                
                callback(planArr)
                
            }
                
            else{
                
                callback(nil)
                
            }
            
        })
        
    }
    
    
    
}

