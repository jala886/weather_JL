//
//  Utils.swift
//  WeatherIcon_JL
//
//  Created by jianli on 5/12/23.
//

import Foundation

class Logger {
    static func info(_ input: Any...) {
        print("INFO: \(Data()):  \(input)")
    }
}

func double2string(_ value: Double) -> String {
    return String(Int(value))
}

func kelvin2celsius(_ value: Double) -> Double {
    value - 273.15
}

func getTimeZoneTime(info: Double?) -> Date {
    let value = Date()
    if let timezone = info {
        return value+timezone
    } else {
        return value
    }
}
