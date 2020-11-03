//
//  DailyTableViewCell.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    static let cellId = "DailyTableViewCell"
    
    private let weekDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = Constants.blackColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = Constants.grayColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = Constants.blackColor
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nightTemp: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.textAlignment = .right
        label.textColor = Constants.grayColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Constants.blueColor
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods
extension DailyTableViewCell {
    private func setupUI() {
        contentView.addSubview(weekDayLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(nightTemp)
        contentView.addSubview(tempLabel)
        contentView.addSubview(weatherImage)
        
        NSLayoutConstraint.activate([
            weekDayLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            weekDayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.sideSpacing)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.sideSpacing),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nightTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.sideSpacing),
            nightTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.sideSpacing * 4),
            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherImage.centerXAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.sideSpacing * 7),
            weatherImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configurateWith(_ dailyWeather: Daily?, and index: Int) {
        dateLabel.text = DateAssistant.shared.getDayAndMonthByIndex(index)
        weekDayLabel.text = DateAssistant.shared.getWeekDayByIndex(index)
        
        guard let imageString = dailyWeather?.weather?.first?.systemIconNameString else { return }
        guard let dayTemp = dailyWeather?.temp?.dayToString else { return }
        guard let nightTemperature = dailyWeather?.temp?.nightToString else { return }
        
        tempLabel.text = dayTemp
        nightTemp.text = nightTemperature
        weatherImage.image = UIImage(systemName: imageString)
    }
}

