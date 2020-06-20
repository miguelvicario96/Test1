//
//  LocationsView.swift
//  Test1
//
//  Created by Miguel Vicario on 19/06/20.
//  Copyright © 2020 Scotiabank. All rights reserved.
//

import UIKit

public class LocationsView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet public var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
}
