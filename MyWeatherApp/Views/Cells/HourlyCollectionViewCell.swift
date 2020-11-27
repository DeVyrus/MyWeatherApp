//
//  HourlyCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import UIKit

final class HourlyCollectionViewCell: UICollectionViewCell {
    
//    MARK: - Properties
    
    static let cellId = "HourlyCollectionViewCell"
    
    private let timeLabel = MyLabel(color: .white, textSize: 14)
    private let tempLabel = MyLabel(color: .white, textSize: 15)
    
    private let imageView = MyImageView(color: .white)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension HourlyCollectionViewCell {
    func configurateWith(_ hourlyWeather: Current?, and index: Int) {
        guard let temp = hourlyWeather?.tempToString else { return }
        guard let imageString = hourlyWeather?.weather?.first?.systemIconNameString else { return }
        
        timeLabel.text = DateAssistant.shared.getTimeFromCurrentHourByIndex(index)
        tempLabel.text = temp
        imageView.image = UIImage(systemName: imageString)
    }
    
    private func setupUI() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

