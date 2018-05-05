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
    var numOfSets : String?
    var numOfRepeats : String?
    var numOfRestTime : String?
    
    
    init(name : String , urlImage : String , urlVideo : String , execDescription : String ) {
        
        self.name = name
        self.urlImage = urlImage
        self.urlVideo = urlVideo
        self.execDescription = execDescription
        self.numOfSets = ""
        self.numOfRepeats = ""
        self.numOfRestTime = ""
        
        
    }
    
    init(name : String , urlImage : String , urlVideo : String , execDescription : String, numOfSets : String, numOfRepeats : String,  numOfRestTime : String) {
        
        self.name = name
        self.urlImage = urlImage
        self.urlVideo = urlVideo
        self.execDescription = execDescription
        self.numOfSets = numOfSets
        self.numOfRepeats = numOfRepeats
        self.numOfRestTime = numOfRestTime
        
    }
    
    init(exercise: Exercise, numOfSets : String, numOfRepeats : String,  numOfRestTime : String)
    {
        self.name = exercise.name
        self.urlImage = exercise.urlImage
        self.urlVideo = exercise.urlVideo
        self.execDescription = exercise.execDescription
        self.numOfSets = numOfSets
        self.numOfRepeats = numOfRepeats
        self.numOfRestTime = numOfRestTime
    }
    
    
    
    
    init(fromJson : [String : Any]) {
        
        name = fromJson["name"] as! String
        urlVideo = fromJson["urlVideo"] as! String
        urlImage = fromJson["urlImage"] as! String
        execDescription = fromJson["execDescription"] as! String
        numOfSets = fromJson["numOfSets"] as? String
        numOfRepeats = fromJson["numOfRepeats"] as? String
        numOfRestTime = fromJson["numOfRestTime"] as? String
    }
    
    
    //convert execrcise obj to json obj
    func toJson() -> [String:Any] {
        
        var jsonObj = [String:Any]()
        jsonObj["name"] = name
        jsonObj["urlImage"] = urlImage
        jsonObj["urlVideo"] = urlVideo
        jsonObj["execDescription"] = execDescription
        jsonObj["numOfSets"] = numOfSets
        jsonObj["numOfRepeats"] = numOfRepeats
         jsonObj["numOfRestTime"] = numOfRestTime
        
        return jsonObj
        
    }
    
    
    
    
    
}
