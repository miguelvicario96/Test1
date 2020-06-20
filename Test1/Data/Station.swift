//
//  Stations.swift
//  Test1
//
//  Created by Miguel Vicario on 18/06/20.
//  Copyright © 2020 Scotiabank. All rights reserved.
//

import Foundation
import CoreLocation

public struct Station {
    
    //MARK: - Properties
    private(set) var id: Int
    private(set) var name: String
    private(set) var address: String
    private(set) var emptySlots: Int
    private(set) var freeBikes: Int
    private(set) var location: CLLocation
    
    //MARK: - Init
    public init(id: Int, name: String, address: String, emptySlots: Int, freeBikes: Int, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.address = address
        self.emptySlots = emptySlots
        self.freeBikes = freeBikes
        self.location = CLLocation(latitude: latitude, longitude: longitude)
    }
}
