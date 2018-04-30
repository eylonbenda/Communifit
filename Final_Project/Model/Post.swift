//
//  Post.swift
//  Final_Project
//
//  Created by Eylon Ben David on 25/02/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Firebase


class Post {
    
    var urlImage : String?
    var description : String?
    var author : String?
    var lastUpdate : Date?
    var postID : String?
    var comments=[Comment]()
    
    init(urlImage : String , description : String? , author : String? ) {
        
        self.postID = NSUUID().uuidString
        self.urlImage = urlImage
        self.description = description
        self.author = author
        
    }
    
    init(urlImage : String , description : String? , author : String?, postID : String? ) {
        
        self.postID = postID
        self.urlImage = urlImage
        self.description = description
        self.author = author
        
    }
    
    init(fromJson : [String : Any]) {
        
        self.postID = fromJson["postID"] as? String
        self.urlImage = fromJson["urlImage"] as? String
        self.description = fromJson["description"] as? String
        self.author = fromJson["author"] as? String
        if let date = fromJson["lastUpdate"] as? Double{
            self.lastUpdate = Date.fromFirebase(date)
        }
        
        if fromJson["comments"] != nil{
            let plans  = fromJson["comments"] as! [String: Any]
            for (_, val) in plans {
                let temp = val as! [String:Any]
                let comment = Comment(json: temp)
                comments.append(comment)
            }
        }
        
        
        
        
    }
    
    
    func postTojson() -> [String:Any]{
        
        var postObj = [String : Any]()
        postObj["urlImage"] = self.urlImage
        postObj["description"] = self.description
        postObj["author"] = self.author
        postObj["postID"] = self.postID
        postObj["lastUpdate"] = ServerValue.timestamp()
        //TODO:  ADD USER VALUE
        return postObj
        
    }
    
    func addCommentToPost() -> [String:Any]{
        
        var mapCmt = [String:Any]()
        mapCmt = myCommentToJson(myComments: comments)
        return mapCmt
        
    }
    
    func myCommentToJson(myComments:[Comment])->[String:Any]
    {
        var map=[String:Any]()
        for  comment in myComments{
            map[comment.commentID!] = comment.commentToJson()
        }
        return map
    }
    
    
    
    
    
    
    
    
}
