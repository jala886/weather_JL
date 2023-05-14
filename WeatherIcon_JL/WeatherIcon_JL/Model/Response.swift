//
//  Response.swift
//  WeatherIcon_JL
//
//  Created by jianli on 5/12/23.
//

import Foundation

// for json parse
struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

public struct Response: Codable {
    let name: String?
    let weather: [Weather]?
    let coord: Coord?
    let main: Main?
    let visibility: Double
    let wind: Wind?
    let timezone: Double
}
