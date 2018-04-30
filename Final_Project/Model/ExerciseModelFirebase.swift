//
//  ModelFirebase.swift
//  Final_Project
//
//  Created by admin on 31/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


class ExerciseModelFirebase  {
    
    let ref : DatabaseReference?
    
     init() {
        
         ref = Database.database().reference()
        
//        FirebaseApp.configure()
//        ref = Database.database().reference()
//
//         configure storage Firebase
//        let storage = Storage.storage()
//        storageRef = storage.reference()
        
        
    }
    
    //TODO: add function addNewExercise(Exercsie)
    
    func addNewExercise(exercise : Exercise){
        
        let myRef = ref?.child("Exercises").child(exercise.name)
        myRef?.setValue(exercise.toJson())
        
        
    }
    
    
    
    //TODO: add getExercise()
    
    func getExercise(exerciseName:String , callback: @escaping (Exercise?) -> Void){
        let myRef=ref?.child("Exercises").child(exerciseName)
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            if let val = snapshot.value as? [String:Any]{
                let exe = Exercise(fromJson: val)
                callback(exe)
            } else {
                callback(nil)
            }
            
        })
        
    }
    
    func getAllChestExercises(callback : @escaping ([Exercise]?) -> Void){
        
        let myRef = ref?.child("MuscleGroup").child("Chest").child("exercises")
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let values = snapshot.value as? [String :  [String : Any] ] {
                
                var exercisesArr = [Exercise]()
                for exeJson in values{
                    
                    let exe = Exercise(fromJson: exeJson.value)
                    exercisesArr.append(exe)
                }
                
                callback(exercisesArr)
                
            } else {
                
                callback(nil)
            }
            
        })
        
        
    }
    
    
    
    func getAllExercises(callback : @escaping ([Exercise]?) -> Void){
        
        let myRef = ref?.child("Exercises")
        myRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            
        if let values = snapshot.value as? [String : [String : Any]] {
                
                var exercisesArr = [Exercise]()
                for exeJson in values{
                    
                    let exe = Exercise(fromJson: exeJson.value)
                    exercisesArr.append(exe)
                }
                
                callback(exercisesArr)
                
            } else {
                
                callback(nil)
            }
            
        })
        
        
    }
    
    
    
    // TODO: update execercise()
    
    
    
    
}
