//
//  Assistants.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import UIKit
import CoreLocation

// Mark: - Constants
struct Constants {
    
    static let blueColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    static let blackColor = #colorLiteral(red: 0.03222160533, green: 0.03222160533, blue: 0.03222160533, alpha: 1)
    static let grayColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    static let sideSpacing: CGFloat = 20
    static let minSpacing: CGFloat = 10
    static let sectionSpacing: CGFloat = 30
    static let itemsCount: CGFloat = 6
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let apiKey = "b4f23272ba07f2c65355e28d88eb14ee"
    
    static var hourlyItemWidth: CGFloat {
        (screenWidth - (sideSpacing * (itemsCount + 1))) / itemsCount
    }
    
    static var pushItemWidth: CGFloat {
        Constants.screenWidth - (Constants.sideSpacing * 2)
    }
    
    static func getUrlStringFrom(_ latitude: Double, and longitude: Double) -> String {
        "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&appid=\(apiKey)&units=metric"
    }
}

// MARK: - Coordinate assistants
struct CoordinateAssistant {
    static let shared = CoordinateAssistant()
    
    private init(){}
    
    func getCoordinateFrom(_ city: String, with completion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
}

// MARK: - Weather assistants
struct WeatherAssistant {
    static let shared = WeatherAssistant()
    
    private init(){}
    
    func getStringFromTemp(_ temp: Double?) -> String {
        guard let currentTemp = temp else { return "" }
        let stringFormat = "\(String(format: "%.0f", currentTemp))º"
        
        if round(currentTemp) > 0 {
            return "+" + stringFormat
        } else if round(currentTemp) < 0 {
            return stringFormat
        }
        return "0º"
    }
    
    func getSystemIconNameFrom(_ id: Int?) -> String {
        guard let condition = id else { return "" }
        switch condition {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "snow"
        case 701...781: return "smoke.fill"
        case 800: return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    func getStringWindFrom(_ windSpeed: Double?) -> String {
        if let speed = windSpeed {
           return "\(String(format: "%.0f", speed)) м/с"
        }
        return ""
    }
    
    func getStringHumidityFrom(_ humidity: Int?) -> String {
        if let humidity = humidity {
            return "\(humidity) %"
        }
        return ""
    }
    
    func getStringPressureFrom(_ pressure: Int?) -> String {
        if let pressure = pressure {
            let atmospheric = Double(pressure) * 0.75
            return "\(String(format: "%.0f", atmospheric)) мм рт.ст."
        }
        return ""
    }
}

// MARK: - Date assistants
struct DateAssistant {
    static let shared = DateAssistant()
    
    private init() {}
    
    func getDayAndMonthByIndex(_ index: Int) -> String {
        setupDateFormatByIndex(index, and: "dd MMMM")
    }
    
    func getWeekDayByIndex(_ index: Int) -> String {
        switch index {
        case 0: return "Сегодня"
        case 1: return "Завтра"
        default: return setupDateFormatByIndex(index, and: "EEEE").capitalizeFirstLetter()
        }
    }
    
    func getTimeFromCurrentHourByIndex(_ index: Int) -> String {
        switch index {
        case 0: return "Cейчас"
        default:
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            let stringCurrentHour = dateFormatter.string(from: date)
            if let intHour = Int(stringCurrentHour) {
                let time = intHour + index
                return time < 24 ? "\(time):00" : "\(time - 24):00"
            }
        }
        return "00:00"
    }
    
    private func setupDateFormatByIndex(_ index: Int, and format: String) -> String {
        guard let modifiedDate = Calendar.current.date(byAdding: .day,
                                                       value: index,
                                                       to: Date()) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter.string(from: modifiedDate)
    }
}
