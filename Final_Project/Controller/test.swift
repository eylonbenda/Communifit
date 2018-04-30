//
//  test.swift
//  Final_Project
//
//  Created by Eylon Ben David on 28/02/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


import UIKit

import MapKit

import CoreLocation



class ViewController: UIViewController,CLLocationManagerDelegate {
    
    
    
    //Alert
    
    let alert = UIAlertController(title: "Add new running location", message: "Enter description", preferredStyle: .alert)
    
    
    
    
    
    //Map
    
    @IBOutlet weak var map: MKMapView!
    
    
    
    
    
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
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        alert.addTextField { (textField) in
            
            textField.text = ""
            
            
            
        }
        
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
        }))
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    
    
    
    
    @IBAction func AddButton(_ sender: Any) {
        
        
        
        addAnnotation()
        
    }
    
    
    
    
    
    func addAnnotation(){
        
        
        
        let textField = self.alert.textFields![0]
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = self.myLocation
        
        annotation.title = textField.text
        
        
        
        self.map.addAnnotation(annotation)
        
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            
            
            let position = touch.location(in: view)
            
            
            
            print(position)
            
            myLocation = map.convert(position, toCoordinateFrom: map)
            
            
            
        }
        
}



}
