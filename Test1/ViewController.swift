//
//  ViewController.swift
//  Test1
//
//  Created by Miguel Vicario on 18/06/20.
//  Copyright © 2020 Scotiabank. All rights reserved.
//

import UIKit
import CoreLocation

public class LocationsViewController: UIViewController {
    
    //MARK: - Instance Properties
    var location: LocationService?
    var stations = [Station]()
    var loadingView = LoadingView()
    
    //MARK: - IBOutlets
    
    //MARK: - App Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        loadingViewShowing(true)
        location = LocationService(delegate: self)
    }
}

//MARK: - LocationServiceDelegate
extension LocationsViewController: LocationServiceDelegate {
    public func didFetchCurrentLocation(_ location: Location) {
        loadingViewShowing(false)
        print(location)
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            stations = delegate.stations
        }
    }
    
    public func fetchCurrentLocationFailed(error: Error) {
        print(error)
    }
}

//MARK: - UITableViewDataSource
extension LocationsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
}

//MARK: - UITableViewDelegate
extension LocationsViewController: UITableViewDelegate {
    
}

//MARK: - LoadingView
extension LocationsViewController {
    func loadingViewShowing(_ showView: Bool) {
        if showView {
            let width = self.view.frame.width
            let height = self.view.frame.height

            loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            self.view.addSubview(loadingView)
            loadingView.activityAlertView.startAnimating()
        } else {
            loadingView.activityAlertView.stopAnimating()
            loadingView.removeFromSuperview()
        }
    }
}
