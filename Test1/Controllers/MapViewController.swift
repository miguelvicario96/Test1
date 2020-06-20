//
//  MapViewController.swift
//  Test1
//
//  Created by Miguel Vicario on 19/06/20.
//  Copyright © 2020 Scotiabank. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

public class MapViewController: UIViewController {
    
    //MARK: - Instance Properties
    var userLocation = CLLocation()
    var pinlocation = CLLocation()
    var name = String()
    
    //MARK: - View
    public var mapView: MapView! {
        guard isViewLoaded else { return nil }
        return (view as! MapView)
    }
    
    //MARK: - App Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setMap()
    }
    
    //MARK: - Methods
    private func setMap() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: pinlocation.coordinate.latitude, longitude: pinlocation.coordinate.longitude)
        annotation.title = name
        mapView.map.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.map.setRegion(region, animated: true)
        
        mapView.map.showsUserLocation = true;
    }
}
