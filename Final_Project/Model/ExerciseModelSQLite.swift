//
//  ExerciseModelSQLite.swift
//  Final_Project
//
//  Created by admin on 09/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class ExerciseModelSQLite : ModelSQLite{
    

    func createTable() -> Bool {

        var errormsg: UnsafeMutablePointer<Int8>? = nil

        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS EXERCISES (NAME TEXT PRIMARY KEY, URLIMAGE TEXT,URLVIDEO TEXT,DESCREPTION TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return false
        }

        return true


    }

    func addNewExercise(exercise : Exercise){


        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO EXERCISES(NAME, URLIMAGE, URLVIDEO,DESCREPTION) VALUES (?,?,?,?);",-1,
                               &sqlite3_stmt,nil) == SQLITE_OK){

            let name = exercise.name.cString(using: .utf8)
            let urlImage = exercise.urlImage.cString(using: .utf8)
            let urlVideo = exercise.urlVideo.cString(using: .utf8)
            let description = exercise.execDescription.cString(using: .utf8)

            sqlite3_bind_text(sqlite3_stmt, 1, name,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, urlImage,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, urlVideo,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, description,-1,nil);

            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }


    }


    func getAllExercises() -> [Exercise]{

        var exercises = [Exercise]()

        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"SELECT * from EXERCISES;",-1,&sqlite3_stmt,nil) == SQLITE_OK){

            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let name = String(cString:sqlite3_column_text(sqlite3_stmt,0) )
                let urlImage = String(cString:sqlite3_column_text(sqlite3_stmt,1) )
                let urlVideo = String(cString:sqlite3_column_text(sqlite3_stmt,2))
                let description = String(cString:sqlite3_column_text(sqlite3_stmt,3))

                exercises.append(Exercise(name: name, urlImage: urlImage, urlVideo: urlVideo, execDescription: description    ))
            }
        }
        sqlite3_finalize(sqlite3_stmt)

        return exercises
    }




    
    
}
