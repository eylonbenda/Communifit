//
//  Comment.swift
//  Final_Project
//
//  Created by ofir kariv on 4/23/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class Comment{
    var author:String?
    var content: String?
    var commentID : String?
    var user : User?
    
    init(content : String,user : User) {
        self.content = content
        self.user = user
    }
    
    
    init(content : String,author : String) {
        self.content = content
        self.author = author
        self.commentID = NSUUID().uuidString
    }
    
    init(json: [String:Any]){
        self.author = json["author"] as? String
        self.content = json["content"] as? String
        self.commentID = json["commentID"] as? String
        
    }
    
    func commentToJson() -> [String:Any]{
        var jsonObject = [String:Any]()
        jsonObject["author"] = self.author
        jsonObject["content"] = self.content
        jsonObject["commentID"] = self.commentID
      return jsonObject
    }
}
