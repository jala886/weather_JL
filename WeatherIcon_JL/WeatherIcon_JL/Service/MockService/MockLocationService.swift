//
//  MockLocationSerice.swift
//  WeatherIcon_JLTests
//
//  Created by jianli on 5/12/23.
//

import Foundation

class MockLocationService: LocationServiceProtocol {
    func getPosition() -> (lat: Double, lon: Double)? {
        return (44.3, 10.99)
    }
    
    
}
