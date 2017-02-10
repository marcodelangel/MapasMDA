//
//  ViewController.swift
//  MapasMDA
//
//  Created by Marco Del Angel on 2/7/17.
//  Copyright © 2017 Marco Del Angel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager: CLLocationManager!
    let regionRadius: CLLocationDistance = 1000
    let appleCoordinates = CLLocation(latitude: 37.33072, longitude: -122.029674)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50.00
        
        centerMapOnLocation(appleCoordinates)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse{
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
        } else{
            locationManager.stopUpdatingLocation()
            map.showsUserLocation = false
        }
    }
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let info = locations[0]
        
        var location = CLLocationCoordinate2D()
        location.latitude = (info.coordinate.latitude)
        location.longitude = (info.coordinate.longitude)
        
        let pin = MKPointAnnotation()
        pin.coordinate = location
        pin.title = "Lat = \(location.latitude) Long = \(location.longitude)"
        pin.subtitle = ""
        map.addAnnotation(pin)
    }
    
    
    @IBAction func normal() {
        map.mapType = .Standard
    }
    
    @IBAction func satelital() {
        map.mapType = .Satellite
    }
    @IBAction func hibrido() {
        map.mapType = .Hybrid
    }
}

