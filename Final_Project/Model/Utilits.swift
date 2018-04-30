//
//  Utilits.swift
//  Final_Project
//
//  Created by Eylon Ben David on 22/02/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit



class Utilits {
    
    
   static func createAlert(viewController : UIViewController,title : String , message :  String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
}
