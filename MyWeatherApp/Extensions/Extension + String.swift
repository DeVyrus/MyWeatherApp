//
//  Extension + String.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizingFirstLetter() {
        self = self.capitalizeFirstLetter()
    }
}
