//
//  Models.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import Foundation

struct Result: Codable {
    let current: Current?
    let hourly: [Current]?
    let daily: [Daily]?
}

struct Current: Codable {
    let temp, feelsLike: Double?
    let weather: [Weather]?
    
    var tempToString: String {
        WeatherAssistant.shared.getStringFromTemp(temp)
    }
    
    var feelsLikeToString: String {
        WeatherAssistant.shared.getStringFromTemp(feelsLike)
    }
    
    enum CodingKeys: String, CodingKey {
        case temp, weather
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int?
    
    var systemIconNameString: String {
        WeatherAssistant.shared.getSystemIconNameFrom(id)
    }
}

struct Daily: Codable {
    let temp: Temp?
    let feelsLike: FeelsLike?
    let weather: [Weather]?
    let pressure, humidity: Int?
    let windSpeed: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp, weather, pressure, humidity
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
    }
    
    var pressureToString: String {
        WeatherAssistant.shared.getStringPressureFrom(pressure)
    }
    
    var humidityToString: String {
        WeatherAssistant.shared.getStringHumidityFrom(humidity)
    }
    
    var windSpeedToString: String {
        WeatherAssistant.shared.getStringWindFrom(windSpeed)
    }
    
}

struct FeelsLike: Codable {
    let day, night, eve, morn: Double?
    
    var dayToString: String {
        WeatherAssistant.shared.getStringFromTemp(day)
    }
    
    var nightToString: String {
        WeatherAssistant.shared.getStringFromTemp(night)
    }
    
    var eveToString: String {
        WeatherAssistant.shared.getStringFromTemp(eve)
    }
    
    var mornToString: String {
        WeatherAssistant.shared.getStringFromTemp(morn)
    }
}

struct Temp: Codable {
    let day, night, eve, morn: Double?
    
    var dayToString: String {
        WeatherAssistant.shared.getStringFromTemp(day)
    }
    
    var nightToString: String {
        WeatherAssistant.shared.getStringFromTemp(night)
    }
    
    var eveToString: String {
        WeatherAssistant.shared.getStringFromTemp(eve)
    }
    
    var mornToString: String {
        WeatherAssistant.shared.getStringFromTemp(morn)
    }
}
