//
//  PostModelFireBase.swift
//  Final_Project
//
//  Created by Eylon Ben David on 25/02/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Firebase


class PostModelFireBase {
    
    
    let ref : DatabaseReference?
    
    init() {
        
        ref = Database.database().reference()
        
    }
    
    
    func addPost(newPost : Post){
        
        let myRef = ref?.child("Posts").child(newPost.postID!)
        myRef?.setValue(newPost.postTojson())
        
    }
    
    func addCommentForPost(post : Post){
        
        let myRef = ref?.child("Posts").child(post.postID!).child("comments")
        myRef?.setValue(post.addCommentToPost())
        
        
        
    }
    
    func getAllCommentsOfPost(uid : String , callback : @escaping ([Comment]?) -> Void){
        
         let myRef = ref?.child("Posts").child(uid).child("comments")
        myRef?.observe(.value, with: { (snapshot) in
            
            if let values = snapshot.value as? [String : [String : Any]] {
                var commentArr = [Comment]()
                for commentJson in values{
                    let comment = Comment(json: commentJson.value)
                    commentArr.append(comment)
                }
                callback(commentArr)
            } else {
                callback(nil)
            }
        })
        
        
    }
    
    func getPostByID(uid : String , callback : @escaping (Post?) -> Void){
        
        let myRef = ref?.child("Posts").child(uid)
        myRef?.observe(.value, with: { (snapShot) in
            if let val = snapShot.value as? [String : Any] {
                
                let post = Post(fromJson: val)
                callback(post)
            } else {
                callback(nil)
            }
        })
        
    }
    
    func getAllPostsAndObserve(lastUpdateDate: Date? ,callback : @escaping ([Post]?)->Void){
            
            let handler = {(snapshot:DataSnapshot) in
                
                if let values = snapshot.value as? [String : [String : Any]] {
                    var postArr = [Post]()
                    for postJson in values{
                        let post = Post(fromJson: postJson.value)
                        postArr.append(post)
                    }
                    callback(postArr)
                } else {
                    callback(nil)
                }
            }
            
            let myRef = ref?.child("Posts")
            
            if (lastUpdateDate != nil){
                print("q starting at:\(lastUpdateDate!) \(lastUpdateDate!.toFirebase())")
                let fbQuery = myRef?.queryOrdered(byChild:"lastUpdate").queryStarting(atValue:lastUpdateDate!.toFirebase())
                fbQuery?.observe(.value, with: handler)
            }else{
                myRef?.observe(.value, with: handler)
            }
    }
    
    
}
