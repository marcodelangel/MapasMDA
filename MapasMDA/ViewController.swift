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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
        } else{
            locationManager.stopUpdatingLocation()
            map.showsUserLocation = false
        }
    }
    func centerMapOnLocation(_ location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    var latestLocation: CLLocation?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let existingLatestLocation = latestLocation else {
            latestLocation = locations.last
            return
        }
        
        guard let newLocation = locations.last else {
            assert(false, "Expecting a location in the location array but it's empty")
            return
        }
        
        let distance = existingLatestLocation.distance(from: newLocation)
        
        var loc = CLLocationCoordinate2D()
        loc.latitude = (newLocation.coordinate.latitude)
        loc.longitude = (newLocation.coordinate.longitude)
        
        let pin = MKPointAnnotation()
        pin.coordinate = loc
        pin.title = "Lat = \(loc.latitude) Long = \(loc.longitude)"
        pin.subtitle = "Distancia= \(distance)"
        map.addAnnotation(pin)
    }
    
    
    @IBAction func normal() {
        map.mapType = .standard
    }
    
    @IBAction func satelital() {
        map.mapType = .satellite
    }
    @IBAction func hibrido() {
        map.mapType = .hybrid
    }
}

