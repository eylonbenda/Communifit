//
//  FirebaseFilesStore.swift
//  Final_Project
//
//  Created by admin on 13/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FirebaseFilesStore {
    
    static var storageRef = Storage.storage().reference(forURL:
        "gs://final-project-ef5ed.appspot.com")
    
    static func saveImageToFirebase(image:UIImage, name:(String),callback:@escaping (String?)->Void){
        let filesRef = storageRef.child(name)
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            filesRef.putData(data, metadata: nil){ (metadata,error) in
                
                if (error != nil) {
                    callback(nil)
                } else {
                    let downloadURL = metadata!.downloadURL()
                    callback(downloadURL?.absoluteString)
                }
                
            }
        }
    }
    
    static func getImageFromFirebase(url:String,callback:@escaping (UIImage?)->Void){
        let ref = storageRef.child(url)
        print(ref)
        ref.getData(maxSize: 10000000) { (data, error) in
            if (error == nil && data != nil){
                let image = UIImage(data: data!)
                callback(image)
            }else{
                callback(nil)
            }
        }
        
    }
    
    
    
    
}
