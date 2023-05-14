//
//  WeatherViewModel.swift
//  WeatherIcon_JL
//
//  Created by jianli on 5/12/23.
//

import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    static let userDefaultKey = "weather_cityName"
    
    @MainActor @Published var weatherInfo = WeatherInfomation()

    private let networkManager: NetworkManagerProtocol
    private let locationService: LocationServiceProtocol
    
    init(networkManager: NetworkManagerProtocol,
         locationService: LocationServiceProtocol) {
        self.networkManager = networkManager
        self.locationService = locationService
    }
    
    func loadData() async {
        var response: Response?
        do {
            if let cityName = await weatherInfo.cityName {
                // (0) have city
                response = try? await networkManager.fetchWeatherInfoByName(cityName: cityName,
                                                                            country: nil, state: nil)
            }else if let cityName = UserDefaults.standard.object(forKey: Self.userDefaultKey) as? String {
                // (1) last city
                response = try? await networkManager.fetchWeatherInfoByName(cityName: cityName ,
                                                                            country: nil, state: nil)
            } else if let position = locationService.getPosition() {
                // (2) user's location city
                response = try await networkManager.fetchWeatherInfoByPosition(lat: position.lat, lon: position.lon)
            } else {
                // (3) default city
                await MainActor.run {
                    weatherInfo.cityName = Global.DEFAULTCITY
                }
                response = try? await networkManager.fetchWeatherInfoByName(cityName: weatherInfo.cityName,
                                                                            country: nil, state: nil)
            }
        } catch (let error) {
            print(error.localizedDescription)
        }
        if let response = response {
            await saveResponseToinfo(response)
            await saveLastCityName()
            // download icon
            if let iconName = response.weather?.first?.icon {
                try? networkManager.fetchIcon(name: iconName){ data in
                    DispatchQueue.main.async {
                        self.weatherInfo.icon = Image(uiImage: (UIImage(data: data) ?? UIImage(systemName: Global.DEFAULTICON)!))
                    }
                }
            }
        }
    }
     
    @MainActor private func saveLastCityName()  {
        if let cityName = self.weatherInfo.cityName {
            UserDefaults.standard.set(cityName, forKey: Self.userDefaultKey)
        }
    }
    @MainActor private func saveResponseToinfo(_ response: Response) {
        self.weatherInfo.cityName = response.name
        self.weatherInfo.lat = response.coord?.lat
        self.weatherInfo.lon = response.coord?.lon
        self.weatherInfo.temp = response.main?.temp
        self.weatherInfo.feelsLike = response.main?.feels_like
        self.weatherInfo.main = response.weather?.first?.main
        self.weatherInfo.desc = response.weather?.description
        self.weatherInfo.windSpeed = response.wind?.speed
        self.weatherInfo.windDegree = response.wind?.deg
        self.weatherInfo.pressure = response.main?.pressure
        self.weatherInfo.humidity = response.main?.humidity
        self.weatherInfo.visibility = response.visibility
        self.weatherInfo.timezone = response.timezone
        
    }
}
