//
//  ModelSQLite.swift
//  Final_Project
//
//  Created by admin on 09/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class ModelSQLite {
    
//    static let instance = ModelSQLite()
    
    var database: OpaquePointer? = nil
    
    init?() {
        
        let dbFileName = "database2.db"
        if let dir = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask).first{
            let path = dir.appendingPathComponent(dbFileName)
            print(path)
            if sqlite3_open(path.absoluteString, &database) != SQLITE_OK {
                print("Failed to open db file: \(path.absoluteString)")
                return nil
            }
        }
        
        if User.createTable(database: database) == false {
            return nil
        }
        if LastUpdateTable.createTable(database: database) == false{
            return nil
        }
        
        
        if Post.createTable(database: database) == false {
            return nil
        }
        
    }
    
}
