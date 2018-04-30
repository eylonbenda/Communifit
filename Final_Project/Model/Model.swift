//
//  Model.swift
//  Final_Project
//
//  Created by Eylon Ben David on 15.1.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class ModelNotificationBase<T> {
    
    var name:String?
    
    init(name:String){
        self.name = name
    }
    
    func observe(callback:@escaping (T?)->Void)->Any{
        return NotificationCenter.default.addObserver(forName: NSNotification.Name(name!), object: nil, queue: nil) { (data) in
            if let data = data.userInfo?["data"] as? T {
                callback(data)
            }
        }
    }
    
    func post(data:T){
        NotificationCenter.default.post(name: NSNotification.Name(name!), object: self, userInfo: ["data":data])
    }
}

class ModelNotification {
    
    static let userList = ModelNotificationBase<[User]>(name: "UserListNotification")
    static let user = ModelNotificationBase<User>(name: "UserNotification")
    static let postList = ModelNotificationBase<[Post]>(name: "PostListNotification")
    static let post = ModelNotificationBase<Post>(name:"PostNotification")
    static let commentsList  = ModelNotificationBase<[Comment]>(name:"CommentsListNotification")
    
    
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    
    }

}


class Model {
    
    
   	static let instance = Model()
    
    
    
    private lazy var postModelFB = PostModelFireBase()
    private lazy var usermodelFirebase = UserModelFirebase()
    private lazy var modelSql = ModelSQLite()
    private lazy var annotationModel = AnnotaionModel()
    
    private init(){
        
    }
    
    func addAnnotationToDB(annotation : Annotaion){
        
        annotationModel.addAnnotationToFB(annotation: annotation)
        
    }
    
    func getAllAnnotation(callback : @escaping ([Annotaion]?)->Void){
        
        annotationModel.getAllAnnotation(callback: callback)
        
    }
    
    func addPost(post : Post){
        
        postModelFB.addPost(newPost: post)
    }
    
    func addCommentToPost(post : Post){
        postModelFB.addCommentForPost(post: post)
    }
    
    func getPostById(post : Post, callback: @escaping (Post?) -> Void){
        postModelFB.getPostByID(uid: post.postID!, callback: callback)
    }
    
    func getAllCommentsOfPost(post : Post){
        postModelFB.getAllCommentsOfPost(uid: post.postID!) { (list) in
            if list != nil {
            ModelNotification.commentsList.post(data: list!)
            for cmt in list!{
                print(cmt.content!)
            }
        }
    }
        
}
    
    
    func getAllPostsAndObserve(){
        
        // get last update date from SQL
        let lastUpdateDate = LastUpdateTable.getLastUpdateDate(database: modelSql?.database, table: "POSTS")
        if lastUpdateDate != nil{
            print(lastUpdateDate!)
        }
        
        // get all updated records from firebase
        postModelFB.getAllPostsAndObserve(lastUpdateDate: lastUpdateDate, callback: { (posts) in
            //update the local db
            var lastUpdate:Date?
            if posts != nil {
            print("got \(posts!.count) new records from FB")
            for post in posts!{
                post.addNewPost(database: self.modelSql?.database)
                if lastUpdate == nil{
                    lastUpdate = post.lastUpdate
                }else{
                    if lastUpdate!.compare(post.lastUpdate!) == ComparisonResult.orderedAscending{
                        lastUpdate = post.lastUpdate
                    }
                }
            }
        }
         
            
            //upadte the last update table
            if (lastUpdate != nil){
                LastUpdateTable.setLastUpdate(database: self.modelSql!.database, table: "POSTS", lastUpdate: lastUpdate!)
            }
            
            //get the complete list from local DB
            var totalList = Post.getAllPosts(database: self.modelSql?.database)
            
            
            
            
           totalList =  totalList.sorted(by:  { (post1, post2) -> Bool in
                
                post1.lastUpdate! > post2.lastUpdate!
            })
            
            for post in totalList {
                print(post.postID)
            }
            
            
            ModelNotification.postList.post(data: totalList)
        })
        
    }


    
    func addUser(user : User){
        
        usermodelFirebase.addNewUser(user: user)
        
    }
    
    func getUser(uid : String , callback : @escaping (User?) -> Void){
        
        usermodelFirebase.getUser(uid: uid, callback: callback)
       
    }
    
    func getAllUsers(callback : @escaping ([User]?)->Void){
        
        usermodelFirebase.getAllUsers(callback: callback)
    }
    
    func getAllUsersAndObserve(){

        // get last update date from SQL
        let lastUpdateDate = LastUpdateTable.getLastUpdateDate(database: modelSql?.database, table: "USERS")
        if lastUpdateDate != nil{
            print(lastUpdateDate!)
        }

        // get all updated records from firebase
        usermodelFirebase.getAllUsersAndObserve(lastUpdateDate: lastUpdateDate, callback: { (users) in
            //update the local db
            print("got \(users!.count) new records from FB")
            var lastUpdate:Date?
            for user in users!{
                user.addNewUser(database: self.modelSql?.database)
                print(user.uid! )
                if lastUpdate == nil{
                    lastUpdate = user.lastUpdate
                }else{
                    if lastUpdate!.compare(user.lastUpdate!) == ComparisonResult.orderedAscending{
                        lastUpdate = user.lastUpdate
                    }
                }
            }

            //upadte the last update table
            if (lastUpdate != nil){
                LastUpdateTable.setLastUpdate(database: self.modelSql!.database, table: "USERS", lastUpdate: lastUpdate!)
            }

            //get the complete list from local DB
            let totalList = User.getAllUsers(database: self.modelSql?.database)
            
            
            ModelNotification.userList.post(data: totalList)
        })

    }
    
    func updateUserImage(user : User  ){
        usermodelFirebase.updateUserImage(user: user)
        
    }
    
    func addPlanToUser(user : User){
        usermodelFirebase.addTrainPlanToUser(user: user)
    }
    
    
    
}
