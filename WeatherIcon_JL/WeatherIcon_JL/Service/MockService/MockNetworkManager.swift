//
//  MockNetworkManager.swift
//  WeatherIcon_JLTests
//
//  Created by jianli on 5/12/23.
//

import Foundation
import UIKit

// MARK: mock data for network manager
class MockNetworkManager: NetworkManagerProtocol {
    
    func fetchWeatherInfoByName(cityName: String? = nil, country: String? = nil, state: String? = nil) async throws -> Response? {
        let data = try! JSONDecoder().decode(Response.self, from: Self.mockData)
        return  data
    }
    
    func fetchWeatherInfoByPosition(lat: Double, lon: Double) async throws -> Response? {
        let data = try! JSONDecoder().decode(Response.self, from: Self.mockData)
        return  data
    }
    
    func fetchIcon(name: String, completionHandler: @escaping (Data) -> Void) throws {
        let icon = UIImage(systemName: name)
        if let data = icon?.pngData() {
            completionHandler(data)
        }
    }
    
    private static let mockData =
                   """
                   {
                     "coord": {
                       "lon": -89.1028,
                       "lat": 30.438
                     },
                     "weather": [
                       {
                         "id": 802,
                         "main": "Clouds",
                         "description": "scattered clouds",
                         "icon": "03d"
                       }
                     ],
                     "base": "stations",
                     "main": {
                       "temp": 300.42,
                       "feels_like": 303.18,
                       "temp_min": 299.79,
                       "temp_max": 301.86,
                       "pressure": 1016,
                       "humidity": 77
                     },
                     "visibility": 10000,
                     "wind": {
                       "speed": 5.66,
                       "deg": 130
                     },
                     "clouds": {
                       "all": 40
                     },
                     "dt": 1683932011,
                     "sys": {
                       "type": 2,
                       "id": 2015175,
                       "country": "US",
                       "sunrise": 1683889460,
                       "sunset": 1683938478
                     },
                     "timezone": -18000,
                     "id": 4429197,
                     "name": "Landon",
                     "cod": 200
                   }
                   """.data(using: .utf8)!
}
