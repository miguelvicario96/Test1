//
//  LocationService.swift
//  Test1
//
//  Created by Miguel Vicario on 19/06/20.
//  Copyright © 2020 Scotiabank. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: - LocationServiceDelegate Declaration
public protocol LocationServiceDelegate: class {
    func didFetchCurrentLocation(_ location: CLLocation)
    func fetchCurrentLocationFailed(error: Error)
}

public class LocationService: NSObject {
    
    //MARK: - Instance Properties
    private let locationManager = CLLocationManager()
    weak var delegate: LocationServiceDelegate?

    //MARK: - Init
    public init(delegate: LocationServiceDelegate) {
        super.init()
        self.delegate = delegate
        self.setupLocationManager()
    }

    //MARK: - Methods
    private func setupLocationManager() {
        if canUseLocationManager() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestWhenInUseAuthorization()
           locationManager.requestLocation()
        }
    }

    private func canUseLocationManager() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    //MARK: - Deinit
    deinit {
        locationManager.stopUpdatingLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let currentLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            delegate?.didFetchCurrentLocation(currentLocation)
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.fetchCurrentLocationFailed(error: error)
    }
}

