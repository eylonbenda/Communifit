//
//  post+sql.swift
//  Final_Project
//
//  Created by Eylon Ben David on 26/02/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation


extension Post{
    
    
    
    static func createTable(database:OpaquePointer?) -> Bool {
        
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS POSTS (POSTID TEXT PRIMARY KEY, URLIMAGE TEXT,DESCREPTION TEXT, AUTHOR TEXT, LASTUPDATE DOUBLE)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return false
        }
        
        return true
        
    }
    
    
    func addNewPost(database:OpaquePointer?) {
        
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO POSTS(POSTID, URLIMAGE, DESCREPTION,AUTHOR,LASTUPDATE) VALUES (?,?,?,?,?);",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            
            let postid = self.postID?.cString(using: .utf8)
            let descreption = self.description?.cString(using: .utf8)
            let author = self.author?.cString(using: .utf8)
           
            var urlImage = "".cString(using: .utf8)
            if self.urlImage != nil {
                urlImage = self.urlImage?.cString(using: .utf8)
            }
            
            sqlite3_bind_text(sqlite3_stmt, 1, postid,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, urlImage,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, descreption,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, author,-1,nil);
            
            if (lastUpdate == nil){
                lastUpdate = Date()
            }
            sqlite3_bind_double(sqlite3_stmt, 5, lastUpdate!.toFirebase());
           
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row at POSTS table is added succefully")
            }
        }
        
        
    }
    
    
    static func getAllPosts(database:OpaquePointer?) -> [Post]{
        
        var posts = [Post]()
        
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"SELECT * from POSTS;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                
                let postID = String(cString:sqlite3_column_text(sqlite3_stmt,0))
                var urlImage : String? = String(cString:sqlite3_column_text(sqlite3_stmt,1))
                if (urlImage != nil && urlImage == ""){
                    urlImage = nil
                }
                
                let descreption = String(cString:sqlite3_column_text(sqlite3_stmt,2))
                let author = String(cString:sqlite3_column_text(sqlite3_stmt,3))
                let lastUpdate = Double(sqlite3_column_double(sqlite3_stmt,4))
                
                
                let post = Post(urlImage: urlImage!, description: descreption, author: author, postID: postID)
                post.lastUpdate = Date.fromFirebase(lastUpdate)
                posts.append(post)
               
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        
        return posts
    }
    
}
