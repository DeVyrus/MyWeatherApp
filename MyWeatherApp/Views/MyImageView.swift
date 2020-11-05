//
//  MyImageView.swift
//  MyWeatherApp
//
//  Created by Денис on 05.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import UIKit

final class MyImageView: UIImageView {
    
    let color: UIColor
    
    init(frame: CGRect = .zero, color: UIColor = .clear) {
        self.color = color
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tintColor = color
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
}
