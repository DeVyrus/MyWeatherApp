//
//  PushCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import UIKit

final class PushCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "PushCollectionViewCell"
    
    private let textLabel = MyLabel(color: Constants.shared.blackColor,
                                    alignment: .left,
                                    textSize: 16)
    
    private let warningImageView = MyImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
        
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.shadowOpacity = 0.2
    }
    
    func updateInterfaceWith(_ index: Int) {
        switch index {
        case 0:
            textLabel.text = "В ближайший час ожидается дождь."
            warningImageView.image = UIImage(named: "water 10.29.01")
        default:
            textLabel.text = "Ожидается усиление ветра до 20 м/c."
            warningImageView.image = UIImage(named: "warning 10.28.58")
        }
    }
}

// MARK: - Methods
extension PushCollectionViewCell {
    private func setupUI() {
        contentView.addSubview(textLabel)
        contentView.addSubview(warningImageView)
        
        NSLayoutConstraint.activate(
            [warningImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.shared.sideSpacing),
             warningImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
             warningImageView.widthAnchor.constraint(equalToConstant: 50),
             warningImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate(
            [textLabel.leadingAnchor.constraint(equalTo: warningImageView.trailingAnchor, constant: Constants.shared.minSpacing),
             textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.shared.sideSpacing),
             textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

