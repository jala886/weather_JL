//
//  NetworkManager.swift
//  20230116-jian&li-NYCSchools
//
//  Created by jianli on 1/16/23.
//

import Foundation

enum NetworkError: Error {
    case fetchWeathError(error: Error)
    case fetchIconError(error: Error)
}

public protocol NetworkManagerProtocol {
    func fetchWeatherInfoByName(cityName: String?, country: String? , state: String? ) async throws -> Response?
    func fetchWeatherInfoByPosition(lat: Double, lon: Double ) async throws -> Response?
    func fetchIcon(name: String, completionHandler:@escaping  (Data)->Void) throws
}

class NetworkManager: NetworkManagerProtocol {
    
    // used async/wait
    func fetchWeatherInfoByName(cityName: String? = nil, country: String? = nil, state: String? = nil) async throws -> Response? {
        let base = URLs.base.string
        guard let cityName = cityName
        else { return nil }
        let urlString = base + "q="+cityName+"&appid="+Global.APPID
        guard let url = URL(string: urlString)
        else{ let error = NSError(domain: "bad url:\(URLs.base.string)", code: -1)
            throw NetworkError.fetchWeathError(error: error)
        }
        Logger.info("fetchWeatherInfoByName: ", url)
        let (data, _) = try await URLSession.shared.data(from:url)
        return try? JSONDecoder().decode(Response.self, from: data)
    }
    
    // used async/wait
    func fetchWeatherInfoByPosition(lat: Double, lon: Double) async throws -> Response? {
        let base = URLs.base.string
        let urlString = base + "lat=\(lat)&lon=\(lon)" + "&appid="+Global.APPID
        guard let url = URL(string: urlString)
        else{ let error = NSError(domain: "bad url:\(URLs.base.string)", code: -1)
            throw NetworkError.fetchWeathError(error: error)
        }
        Logger.info("fetchWeatherInfoByPosition: ", url)
        let (data, _) = try await URLSession.shared.data(from:url)
        return try? JSONDecoder().decode(Response.self, from: data)
    }
    
    // used clourser
    func fetchIcon(name: String, completionHandler:@escaping  (Data)->Void) throws {
        guard let url = URL(string: URLs.icon(name: name, size: Global.ICONSIZE).string)
        else{ let error = NSError(domain: "bad url:\(URLs.base.string)", code: -1)
            throw NetworkError.fetchIconError(error: error)
        }
        Logger.info("fetchIcon: ", url)
        URLSession.shared.dataTask(with: url) { (data, r, error) in
            if let data = data {
                completionHandler(data)
            }
        }.resume()
    }
}
