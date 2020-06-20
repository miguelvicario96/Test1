//
//  AppDelegate.swift
//  Test1
//
//  Created by Guillermo Guizar on 7/2/19.
//  Copyright © 2019 Scotiabank. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private(set) var stations = [Station]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let navigationController = application.windows[0].rootViewController as? UINavigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
            navigationController.navigationBar.isHidden = true
        }
       
        let apiManager = ApiManager();
        
        apiManager.getData { (json) in
            for estacion in json["network"]["stations"].arrayValue {
                if (estacion["extra"]["status"].stringValue == "OPN" && estacion["free_bikes"].intValue != 0) {
                    //ID
                    let id = estacion["extra"]["uid"].intValue
                    
                    //Name
                    let name = estacion["name"].stringValue.split(separator: " ").dropFirst().joined(separator: " ").capitalized
                    
                    //Address
                    var address = estacion["extra"]["address"].stringValue;
                    address = address.replacingOccurrences(of: #"([0-9]){3}\s*-*\s*"#, with: "", options: .regularExpression)
                    address = address.capitalized
                    
                    //Empty Slots
                    let emptySlots = estacion["empty_slots"].intValue
                    
                    //Free Bikes
                    let freeBikes = estacion["free_bikes"].intValue
                    
                    //Latitude - Longitude
                    let latitude = estacion["latitude"].doubleValue
                    let longitude = estacion["longitude"].doubleValue
                    
                    //Append to Stations Array
                    let station = Station(id: id, name: name, address: address, emptySlots: emptySlots, freeBikes: freeBikes, latitude: latitude, longitude: longitude)
                    self.stations.append(station)
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

