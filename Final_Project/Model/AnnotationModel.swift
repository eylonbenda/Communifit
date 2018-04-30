//
//  AnnotationModel.swift
//  Final_Project
//
//  Created by Eylon Ben David on 27/02/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Firebase


class AnnotaionModel {
    
    let ref : DatabaseReference?
    
    init() {
        
        ref = Database.database().reference()
        
    }
    
    func addAnnotationToFB(annotation : Annotaion){
        
        let myRef = ref?.child("Annotation").child(annotation.annotationId)
        myRef?.setValue(annotation.AnnotationToJson())
        
        
    }
    
    func getAllAnnotation(callback : @escaping ([Annotaion]?)->Void){
        
        let myRef = ref?.child("Annotation")
        myRef?.observe(.value, with: { (snapshot) in
            
            if let values = snapshot.value as? [String : [String : Any]] {
                
                var anoArr = [Annotaion]()
                for annotationJson in values{
                    
                    let annotation = Annotaion(map: annotationJson.value)
                    anoArr.append(annotation)
                }
                
                callback(anoArr)
                
            } else {
                
                callback(nil)
            }
        })
    }
    
    
}
