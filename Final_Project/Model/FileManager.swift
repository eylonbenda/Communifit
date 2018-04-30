//
//  FileManager.swift
//  Final_Project
//
//  Created by admin on 12/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit


class FileManager {
    
    var userModel : UserModelFirebase?
    
    init() {
        userModel = UserModelFirebase()
    }
    
    func saveImage(image:UIImage, name:String,callback:@escaping (String?)->Void){
        //1. save image to Firebase
        userModel?.saveImageToFirebase(image: image,name: name, callback: {(url) in
            if (url != nil){
        //2. save image localy
                self.saveImageToFile(image: image, name: name)
            }
        //3. notify the user on complete
            callback(url)
        })
    }
    
    
    
    
    
    
}
