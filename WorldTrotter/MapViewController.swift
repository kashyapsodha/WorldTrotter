//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Kashyap Sodha on 2/16/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var start:Bool = true
    var pins = [MKPointAnnotation]()
    var currentPosition = 0
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        view = mapView
        
        let segmentedControl
            = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let button = UIButton(frame: CGRect(x: 250, y: 750, width: 150, height: 40))
        button.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Next Location", for: .normal)
        button.addTarget(self, action: #selector(changeButton), for: .touchUpInside)
        view.addSubview(button)
        
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor,
                                                  constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    @objc func changeButton(){
        currentPosition = (currentPosition + 1)%3
        let center = CLLocationCoordinate2D(latitude: pins[currentPosition].coordinate.latitude, longitude: pins[currentPosition].coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let currentLocation:CLLocationCoordinate2D =  manager.location!.coordinate
        let currentPin = MKPointAnnotation()
        currentPin.coordinate = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        currentPin.title = "Current Location"
        mapView.addAnnotation(currentPin)
        print("Current location is pinned")
        
        if start{
            pins.append(currentPin)
            let center = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            start = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.stopUpdatingLocation()
        //print("MapViewController loaded its view.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
        let mumbaiPin = MKPointAnnotation()
        mumbaiPin.coordinate = CLLocationCoordinate2D(latitude: 19.07283, longitude: 72.88261)
        mumbaiPin.title = "Mumbai"
        mapView.addAnnotation(mumbaiPin)
        pins.append(mumbaiPin)
        print("Mumbai's location is pinned")
        
        let sfPin = MKPointAnnotation()
        sfPin.coordinate = CLLocationCoordinate2D(latitude: 37.773972 , longitude: -122.431297)
        sfPin.title = "San Francisco"
        mapView.addAnnotation(sfPin)
        pins.append(sfPin)
        print("San Francisco's location is pinned")
    }
    
}
