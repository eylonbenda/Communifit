//
//  Annotation.swift
//  Final_Project
//
//  Created by Eylon Ben David on 27/02/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class Annotaion{
    
    var long : Double?
    var lat : Double?
    var text : String?
    var annotationId = NSUUID().uuidString
    
    init(long : Double , lat : Double, text : String) {
        self.long = long
        self.lat = lat
        self.text = text
    }
    
    init(map : [String: Any] ) {
        self.long = map["long"] as? Double
        self.lat = map["lat"] as? Double
        self.text = map["text"] as? String
    }
    func AnnotationToJson() -> [String:Any] {
        
        var jsonObj = [String:Any]()
        jsonObj["long"] = long
        jsonObj["lat"] = lat
        jsonObj["text"] = text
        return jsonObj
        
    }
    
    
    
    
    
}
