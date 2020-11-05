//
//  MyLabel.swift
//  MyWeatherApp
//
//  Created by Денис on 05.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import UIKit

final class MyLabel: UILabel {
    
    let color: UIColor
    let labelText: String
    let textSize: CGFloat
    let alignment: NSTextAlignment
    
    init(frame: CGRect = .zero, labelText: String = "", color: UIColor, alignment: NSTextAlignment = .left, textSize: CGFloat = 14) {
        
        self.color = color
        self.labelText = labelText
        self.alignment = alignment
        self.textSize = textSize
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = UIFont(name: "HelveticaNeue", size: textSize)
        text = labelText
        textColor = color
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
}

