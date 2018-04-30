//
//  Exercise.swift
//  Final_Project
//
//  Created by admin on 28/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation


class Exercise {
    
    
    var name : String = ""
    var urlImage : String = ""
    var urlVideo : String = ""
    var execDescription : String = ""
    
    
    init(name : String , urlImage : String , urlVideo : String , execDescription : String ) {
        
        self.name = name
        self.urlImage = urlImage
        self.urlVideo = urlVideo
        self.execDescription = execDescription
        
    }
    
    
    init(fromJson : [String : Any]) {
        
        name = fromJson["name"] as! String
        urlVideo = fromJson["urlVideo"] as! String
        urlImage = fromJson["urlImage"] as! String
        execDescription = fromJson["execDescription"] as! String
        
    }
    
    
    //convert execrcise obj to json obj
    func toJson() -> [String:Any] {
        
        var jsonObj = [String:Any]()
        jsonObj["name"] = name
        jsonObj["urlImage"] = urlImage
        jsonObj["urlVideo"] = urlVideo
        jsonObj["execDescription"] = execDescription
        
        return jsonObj
        
    }
    
    
    
    
    
}
