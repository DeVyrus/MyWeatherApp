//
//  WeatherDetailsViewController.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    var dailyWeather: Daily?
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Днем"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blueColor
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private let mornLabel: UILabel = {
        let label = UILabel()
        label.text = "Утром"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blueColor
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private let eveLabel: UILabel = {
        let label = UILabel()
        label.text = "Вечером"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blueColor
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private let nightLabel: UILabel = {
        let label = UILabel()
        label.text = "Ночью"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blueColor
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private let dayTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blackColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let mornTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blackColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let eveTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blackColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let nightTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blackColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
        
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Ощущается как"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.grayColor
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        return label
    }()
    
    private let dayFeelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.grayColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let mornFeelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.grayColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let eveFeelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.grayColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let nightFeelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.grayColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.text = "Ветер"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blueColor
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "Влажность"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blueColor
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private let pressureLabel: UILabel = {
        let label = UILabel()
        label.text = "Давление"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blueColor
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.grayColor
        return view
    }()
    
    private let windValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blackColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let humidityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blackColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let pressureValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blackColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
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
            mornLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.screenHeight * 0.15),
            mornLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideSpacing)
        ])
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.screenHeight * 0.15),
            dayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.screenWidth * 0.3)
        ])
        
        NSLayoutConstraint.activate([
            eveLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.screenHeight * 0.15),
            eveLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.screenWidth * 0.55)
        ])
        
        NSLayoutConstraint.activate([
            nightLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.screenHeight * 0.15),
            nightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.screenWidth * 0.8)
        ])
        
        NSLayoutConstraint.activate([
            mornTempLabel.topAnchor.constraint(equalTo: mornLabel.bottomAnchor, constant: Constants.minSpacing),
            mornTempLabel.leadingAnchor.constraint(equalTo: mornLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dayTempLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: Constants.minSpacing),
            dayTempLabel.leadingAnchor.constraint(equalTo: dayLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eveTempLabel.topAnchor.constraint(equalTo: eveLabel.bottomAnchor, constant: Constants.minSpacing),
            eveTempLabel.leadingAnchor.constraint(equalTo: eveLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nightTempLabel.topAnchor.constraint(equalTo: nightLabel.bottomAnchor, constant: Constants.minSpacing),
            nightTempLabel.leadingAnchor.constraint(equalTo: nightLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            feelsLikeLabel.topAnchor.constraint(equalTo: mornTempLabel.bottomAnchor, constant: Constants.sectionSpacing),
            feelsLikeLabel.leadingAnchor.constraint(equalTo: mornTempLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mornFeelsLikeTempLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: Constants.minSpacing),
            mornFeelsLikeTempLabel.leadingAnchor.constraint(equalTo: feelsLikeLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dayFeelsLikeTempLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: Constants.minSpacing),
            dayFeelsLikeTempLabel.leadingAnchor.constraint(equalTo: dayLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eveFeelsLikeTempLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: Constants.minSpacing),
            eveFeelsLikeTempLabel.leadingAnchor.constraint(equalTo: eveLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nightFeelsLikeTempLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: Constants.minSpacing),
            nightFeelsLikeTempLabel.leadingAnchor.constraint(equalTo: nightLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: mornFeelsLikeTempLabel.bottomAnchor, constant: Constants.sectionSpacing / 2),
            separator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.widthAnchor.constraint(equalToConstant: Constants.screenWidth - (Constants.sideSpacing * 2))
        ])
        
        NSLayoutConstraint.activate([
            windLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: Constants.sectionSpacing / 2),
            windLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideSpacing)
        ])
        
        NSLayoutConstraint.activate([
            humidityLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: Constants.sectionSpacing / 2),
            humidityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.screenWidth * 0.3)
        ])
        
        NSLayoutConstraint.activate([
            pressureLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: Constants.sectionSpacing / 2),
            pressureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.screenWidth * 0.55)
        ])
        
        NSLayoutConstraint.activate([
            windValueLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: Constants.minSpacing),
            windValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideSpacing)
        ])
        
        NSLayoutConstraint.activate([
            humidityValueLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: Constants.minSpacing),
            humidityValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.screenWidth * 0.3)
        ])
        
        NSLayoutConstraint.activate([
            pressureValueLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: Constants.minSpacing),
            pressureValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.screenWidth * 0.55)
        ])
    }
}

