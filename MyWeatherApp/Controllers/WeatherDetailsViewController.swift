//
//  WeatherDetailsViewController.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import UIKit

final class WeatherDetailsViewController: UIViewController {
    
    var dailyWeather: Daily?
    
    private let dayLabel = MyLabel(labelText: "Днем", color: Constants.shared.blueColor)
    private let mornLabel = MyLabel(labelText: "Утром", color: Constants.shared.blueColor)
    private let eveLabel = MyLabel(labelText: "Вечером", color: Constants.shared.blueColor)
    private let nightLabel = MyLabel(labelText: "Ночью", color: Constants.shared.blueColor)
    
    private let dayTempLabel = MyLabel(color: Constants.shared.blackColor,
                                       alignment: .right,
                                       textSize: 16)
    private let mornTempLabel = MyLabel(color: Constants.shared.blackColor,
                                        alignment: .right,
                                        textSize: 16)
    private let eveTempLabel = MyLabel(color: Constants.shared.blackColor,
                                       alignment: .right,
                                       textSize: 16)
    private let nightTempLabel = MyLabel(color: Constants.shared.blackColor,
                                         alignment: .right,
                                         textSize: 16)
    
    private let feelsLikeLabel = MyLabel(labelText: "Ощущается как",
                                         color: Constants.shared.grayColor,
                                         textSize: 12)
    
    private let dayFeelsLikeTempLabel = MyLabel(color: Constants.shared.grayColor,
                                       alignment: .right,
                                       textSize: 16)
    private let mornFeelsLikeTempLabel = MyLabel(color: Constants.shared.grayColor,
                                        alignment: .right,
                                        textSize: 16)
    private let eveFeelsLikeTempLabel = MyLabel(color: Constants.shared.grayColor,
                                       alignment: .right,
                                       textSize: 16)
    private let nightFeelsLikeTempLabel = MyLabel(color: Constants.shared.grayColor,
                                         alignment: .right,
                                         textSize: 16)
    
    private let windLabel = MyLabel(labelText: "Ветер", color: Constants.shared.blueColor)
    private let humidityLabel = MyLabel(labelText: "Влажность", color: Constants.shared.blueColor)
    private let pressureLabel = MyLabel(labelText: "Давление", color: Constants.shared.blueColor)
    
    private let windValueLabel = MyLabel(color: Constants.shared.blackColor,
                                       alignment: .right,
                                       textSize: 16)
    private let humidityValueLabel = MyLabel(color: Constants.shared.blackColor,
                                        alignment: .right,
                                        textSize: 16)
    private let pressureValueLabel = MyLabel(color: Constants.shared.blackColor,
                                       alignment: .right,
                                       textSize: 16)
    
    private let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.shared.grayColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Подробный прогноз"
        view.backgroundColor = .white
        
        setupUI()
        updateInterface()
    }
}

// MARK: - Private methods
extension WeatherDetailsViewController {
    
    private func updateInterface() {
        
        guard let weather = dailyWeather else { return }
        
        mornTempLabel.text = weather.temp?.mornToString
        dayTempLabel.text = weather.temp?.dayToString
        eveTempLabel.text = weather.temp?.eveToString
        nightTempLabel.text = weather.temp?.nightToString
        
        mornFeelsLikeTempLabel.text = weather.feelsLike?.mornToString
        dayFeelsLikeTempLabel.text = weather.feelsLike?.dayToString
        eveFeelsLikeTempLabel.text = weather.feelsLike?.eveToString
        nightFeelsLikeTempLabel.text = weather.feelsLike?.nightToString
        
        windValueLabel.text = weather.windSpeedToString
        humidityValueLabel.text = weather.humidityToString
        pressureValueLabel.text = weather.pressureToString
    }
    
    private func setupUI() {
                
        view.addSubview(mornLabel)
        view.addSubview(dayLabel)
        view.addSubview(eveLabel)
        view.addSubview(nightLabel)
        
        view.addSubview(mornTempLabel)
        view.addSubview(dayTempLabel)
        view.addSubview(eveTempLabel)
        view.addSubview(nightTempLabel)
        
        view.addSubview(feelsLikeLabel)
        
        view.addSubview(mornFeelsLikeTempLabel)
        view.addSubview(dayFeelsLikeTempLabel)
        view.addSubview(eveFeelsLikeTempLabel)
        view.addSubview(nightFeelsLikeTempLabel)
        
        view.addSubview(separator)
        
        view.addSubview(windLabel)
        view.addSubview(humidityLabel)
        view.addSubview(pressureLabel)
        
        view.addSubview(windValueLabel)
        view.addSubview(humidityValueLabel)
        view.addSubview(pressureValueLabel)
        
        NSLayoutConstraint.activate([
            mornLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.shared.screenHeight * 0.15),
            mornLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.shared.sideSpacing)
        ])
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.shared.screenHeight * 0.15),
            dayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.shared.screenWidth * 0.3)
        ])
        
        NSLayoutConstraint.activate([
            eveLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.shared.screenHeight * 0.15),
            eveLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.shared.screenWidth * 0.55)
        ])
        
        NSLayoutConstraint.activate([
            nightLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.shared.screenHeight * 0.15),
            nightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.shared.screenWidth * 0.8)
        ])
        
        NSLayoutConstraint.activate([
            mornTempLabel.topAnchor.constraint(equalTo: mornLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            mornTempLabel.leadingAnchor.constraint(equalTo: mornLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dayTempLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            dayTempLabel.leadingAnchor.constraint(equalTo: dayLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eveTempLabel.topAnchor.constraint(equalTo: eveLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            eveTempLabel.leadingAnchor.constraint(equalTo: eveLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nightTempLabel.topAnchor.constraint(equalTo: nightLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            nightTempLabel.leadingAnchor.constraint(equalTo: nightLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            feelsLikeLabel.topAnchor.constraint(equalTo: mornTempLabel.bottomAnchor, constant: Constants.shared.sectionSpacing),
            feelsLikeLabel.leadingAnchor.constraint(equalTo: mornTempLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mornFeelsLikeTempLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            mornFeelsLikeTempLabel.leadingAnchor.constraint(equalTo: feelsLikeLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dayFeelsLikeTempLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            dayFeelsLikeTempLabel.leadingAnchor.constraint(equalTo: dayLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eveFeelsLikeTempLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            eveFeelsLikeTempLabel.leadingAnchor.constraint(equalTo: eveLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nightFeelsLikeTempLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            nightFeelsLikeTempLabel.leadingAnchor.constraint(equalTo: nightLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: mornFeelsLikeTempLabel.bottomAnchor, constant: Constants.shared.sectionSpacing / 2),
            separator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.widthAnchor.constraint(equalToConstant: Constants.shared.screenWidth - (Constants.shared.sideSpacing * 2))
        ])
        
        NSLayoutConstraint.activate([
            windLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: Constants.shared.sectionSpacing / 2),
            windLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.shared.sideSpacing)
        ])
        
        NSLayoutConstraint.activate([
            humidityLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: Constants.shared.sectionSpacing / 2),
            humidityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.shared.screenWidth * 0.3)
        ])
        
        NSLayoutConstraint.activate([
            pressureLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: Constants.shared.sectionSpacing / 2),
            pressureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.shared.screenWidth * 0.55)
        ])
        
        NSLayoutConstraint.activate([
            windValueLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            windValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.shared.sideSpacing)
        ])
        
        NSLayoutConstraint.activate([
            humidityValueLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            humidityValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.shared.screenWidth * 0.3)
        ])
        
        NSLayoutConstraint.activate([
            pressureValueLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: Constants.shared.minSpacing),
            pressureValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.shared.screenWidth * 0.55)
        ])
    }
}

