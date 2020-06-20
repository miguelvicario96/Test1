//
//  ApiManager.swift
//  Test1
//
//  Created by Guillermo Guizar on 7/2/19.
//  Copyright © 2019 Scotiabank. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApiManager {
    /// Get data
    ///
    /// - Parameter success: Response json object ready to be parsed
    func getData(success: @escaping (_ response: JSON) -> Void) {
        let path = Bundle.main.path(forResource: "ecobici", ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        success(JSON(parseJSON: jsonString!))
    }
}
