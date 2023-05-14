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
        let status = manager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .notDetermined, .restricted, .denied:
            manager.requestLocation()
        @unknown default:
            fatalError()
        }
        manager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }
        position = userLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                manager.requestLocation()
            }
        }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func getPosition() -> (lat: Double, lon: Double)? {
        if let position = position {
            return (position.coordinate.latitude, position.coordinate.longitude)
        } else {
            return nil
        }
    }
}

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()

    @Published var lastSearchedCity = ""

    var hasFoundOnePlacemark:Bool = false

    func checkIfLocationServicesIsEnabled(){
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest/// kCLLocationAccuracyBest is the default
                self.checkLocationAuthorization()
            }else{
                // show message: Services desabled!
            }
        }
    }

    private func checkLocationAuthorization(){
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // show message
            break
        case .denied:
            // show message
            break
        case .authorizedWhenInUse, .authorizedAlways:
            /// app is authorized
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        hasFoundOnePlacemark = false

        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)-> Void in
            if error != nil {
                self.locationManager.stopUpdatingLocation()
                // show error message
            }
            if placemarks!.count > 0 {
                if !self.hasFoundOnePlacemark{
                    self.hasFoundOnePlacemark = true
                    let placemark = placemarks![0]

                    self.lastSearchedCity = placemark.locality ?? ""
                }
                self.locationManager.stopUpdatingLocation()
            }else{
                // no places found
            }
        })
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
