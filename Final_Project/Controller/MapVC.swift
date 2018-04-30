//
//  MapVC.swift
//  Final_Project
//
//  Created by Eylon Ben David on 27/02/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import  MapKit
import CoreLocation

class MapVC: UIViewController , CLLocationManagerDelegate {

   
    //Map
    @IBOutlet weak var map: MKMapView!
    
    var annotations = [Annotaion]()
    
    var textFiled : UITextField?


    //Locations
    
    var myLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    
    let manager = CLLocationManager()
    
    let clickedLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        let span : MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
        
        
        Model.instance.getAllAnnotation { (annotationss) in
            
            if annotationss != nil {
                self.annotations = annotationss!
                
                for fbAnnotation in self.annotations {
                    
                    let newAnnotation = MKPointAnnotation()
                    
                    newAnnotation.coordinate.latitude = fbAnnotation.lat!
                    
                    newAnnotation.coordinate.longitude = fbAnnotation.long!
                    newAnnotation.title = fbAnnotation.text
                    self.map.addAnnotation(newAnnotation)
                    
                }
                
            }
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
   
    @IBAction func addButton(_ sender: Any) {
        showAlert()
    }
    

    
    func addAnnotation(titel : String){
        
        var anno : Annotaion?
        //textFiled = self.alert.textFields![0]
        let annotation = MKPointAnnotation()
        annotation.coordinate = myLocation
       // annotation.title = textFiled?.text
        annotation.title = titel
        
        self.map.addAnnotation(annotation)
       // self.present(alert, animated: true, completion: nil)
        
        
        print(annotation.title)
        
        
        anno = Annotaion(long: annotation.coordinate.longitude, lat: annotation.coordinate.latitude, text: annotation.title!)
        Model.instance.addAnnotationToDB(annotation: anno!)
        
        
        
    }
    

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let position = touch.location(in: view)
            print(position)
            
            myLocation = map.convert(position, toCoordinateFrom: map)
        
            
        }
        
        
        
        
    }
    
    
    func showAlert(){
        
        var myTitle : String?
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Describe your Loaction", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            myTitle = textField?.text
            print("Text field: \(textField?.text)")
           self.addAnnotation(titel: (myTitle)!)
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
        
    }
    

}
