//
//  LocationsTableViewCell.swift
//  Test1
//
//  Created by Miguel Vicario on 19/06/20.
//  Copyright © 2020 Scotiabank. All rights reserved.
//

import UIKit

public class LocationsTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet public var nameLabel: UILabel!
    @IBOutlet public var addressLabel: UILabel!
    @IBOutlet public var emptySlotsLabel: UILabel!
    @IBOutlet public var freeBikesLabel: UILabel!
    
    //MARK: - Methods
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
}
