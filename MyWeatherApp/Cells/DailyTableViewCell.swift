//
//  DailyTableViewCell.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import UIKit

final class DailyTableViewCell: UITableViewCell {
    
    static let cellId = "DailyTableViewCell"
    
    private let weekDayLabel = MyLabel(color: Constants.shared.blackColor, textSize: 16)
    private let dateLabel = MyLabel(color: Constants.shared.blackColor, textSize: 12)
    
    private let tempLabel = MyLabel(color: Constants.shared.blackColor,
                                    alignment: .right,
                                    textSize: 14)
    private let nightTemp = MyLabel(color: Constants.shared.grayColor,
                                    alignment: .right,
                                    textSize: 13)
    
    private let weatherImage = MyImageView(color: Constants.shared.blueColor)

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
            weekDayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.shared.sideSpacing)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.shared.sideSpacing),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nightTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.shared.sideSpacing),
            nightTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.shared.sideSpacing * 4),
            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherImage.centerXAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.shared.sideSpacing * 7),
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

