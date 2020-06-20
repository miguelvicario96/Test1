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
    var locationService: LocationService?
    var userLocation = CLLocation()
    var stations = [Station]()
    var loadingView = LoadingView()
    
    //MARK: - View
    public var locationsView: LocationsView! {
        guard isViewLoaded else { return nil }
        return (view as! LocationsView)
    }
    
    //MARK: - App Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        loadingViewShowing(true)
        locationService = LocationService(delegate: self)
        tableViewConfig()
    }
    
    //MARK: - Methods
    private func tableViewConfig() {
        locationsView.tableView.register(UINib(nibName: "LocationsTableViewCell", bundle: nil),
                                         forCellReuseIdentifier: "LocationsCell")
        locationsView.tableView.estimatedRowHeight = 192
        locationsView.tableView.rowHeight = UITableView.automaticDimension
    }
}

//MARK: - LocationServiceDelegate
extension LocationsViewController: LocationServiceDelegate {
    public func didFetchCurrentLocation(_ location: CLLocation) {
        navigationController?.navigationBar.isHidden = false
        
        userLocation = location
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        stations = delegate.stations
        
        stations = stations.sorted(by: {
            $0.location.distance(from: location) < $1.location.distance(from: location)
        })
        
        locationsView.tableView.reloadData()
        loadingViewShowing(false)
    }
    
    public func fetchCurrentLocationFailed(error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: "Hubo Un Error Con La Localización",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension LocationsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsCell", for: indexPath) as! LocationsTableViewCell
        cell.nameLabel.text = stations[indexPath.row].name
        cell.addressLabel.text = stations[indexPath.row].address
        cell.emptySlotsLabel.text = "\(stations[indexPath.row].emptySlots)"
        cell.freeBikesLabel.text = "\(stations[indexPath.row].freeBikes)"
        return cell
    }
}

//MARK: - UITableViewDelegate
extension LocationsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapView") as! MapViewController
        vc.userLocation = userLocation
        vc.pinlocation = stations[indexPath.row].location
        vc.name = stations[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
    }
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
