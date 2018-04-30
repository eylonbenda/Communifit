
//
//  UserModelSQL.swift
//  Final_Project
//
//  Created by admin on 30/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation


class UserModelSQL : ModelSQLite {
    
    
    override init?() {
        super.init()
        
        if(!createTable()){
            return nil
        }
    }
    
    
    func createTable() -> Bool {
        
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS USERS (UID TEXT PRIMARY KEY, USERNAME TEXT,FULLNAME TEXT,EMAIL TEXT,WIGHT TEXT,HIGHT TEXT,PROFILEIMAGE TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return false
        }
        
        return true
        
    }
    
    func addNewUser(user : User){
        
        
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO USERS(UID, USERNAME, FULLNAME,EMAIL,WIGHT,HIGHT,PROFILEIMAGE) VALUES (?,?,?,?,?,?,?);",-1,
                               &sqlite3_stmt,nil) == SQLITE_OK){
            
            let uid = user.uid?.cString(using: .utf8)
            let username = user.userName?.cString(using: .utf8)
            let fullname = user.fullName?.cString(using: .utf8)
            let email = user.email?.cString(using: .utf8)
            let hight = user.hight?.cString(using: .utf8)
            let wight = user.wight?.cString(using: .utf8)
            var profileImageUrl = "".cString(using: .utf8)
            if user.urlImage != nil {
                profileImageUrl = user.urlImage?.cString(using: .utf8)
            }
            
            
            sqlite3_bind_text(sqlite3_stmt, 1, uid,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, username,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, fullname,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, email,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, hight,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, wight,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 7, profileImageUrl,-1,nil);
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
        
        
    }
    
    
    func getAllUsers() -> [User]{
        
        var users = [User]()
        
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"SELECT * from USERS;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let uid = String(cString:sqlite3_column_text(sqlite3_stmt,0) )
                let username = String(cString:sqlite3_column_text(sqlite3_stmt,1) )
                let fullName = String(cString:sqlite3_column_text(sqlite3_stmt,2))
                 let email = String(cString:sqlite3_column_text(sqlite3_stmt,3))
                let wight = String(cString:sqlite3_column_text(sqlite3_stmt,4))
                let higth = String(cString:sqlite3_column_text(sqlite3_stmt,5))
                var profileUrl : String?
                 profileUrl = String(cString:sqlite3_column_text(sqlite3_stmt,6))
                
                if (profileUrl != nil && profileUrl == ""){
                    profileUrl = nil
                }
                
                users.append(User(uid: uid, email: email, userName: username, fullName: fullName, hight: higth, wight: wight,urlImage: profileUrl))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        
        return users
    }

    
    
    
    
}
