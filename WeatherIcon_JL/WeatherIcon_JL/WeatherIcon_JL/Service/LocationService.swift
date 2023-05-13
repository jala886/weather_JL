//
//  LocationService.swift
//  WeatherIcon_JL
//
//  Created by jianli on 5/12/23.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    // return (lat, lon) or nil
    func getPosition() -> (lat: Double, lon: Double)?
}

class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    
    private var manager: CLLocationManager = CLLocationManager()
    private var position: CLLocation?

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        position = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                manager.requestLocation()
            }
        }
    
    func getPosition() -> (lat: Double, lon: Double)? {
        if let position = manager.location {
            return (position.coordinate.latitude, position.coordinate.longitude)
        } else {
            return nil
        }
    }
}
