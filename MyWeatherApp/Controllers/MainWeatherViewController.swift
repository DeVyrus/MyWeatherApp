//
//  MainWeatherViewController.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import UIKit
import CoreLocation

final class MainWeatherViewController: UIViewController {

//    MARK: - Properties
    
    private var result: Result?
    
    lazy var locationManager: CLLocationManager = {
       let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    lazy var hourlyWeatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: Constants.shared.sideSpacing,
                                           bottom: 0, right: Constants.shared.sideSpacing)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.shared.sideSpacing
        
        layout.itemSize = CGSize(width: Constants.shared.hourlyItemWidth,
                                 height: Constants.shared.hourlyItemWidth * 2)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HourlyCollectionViewCell.self,
                                forCellWithReuseIdentifier: HourlyCollectionViewCell.cellId)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var pushCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: Constants.shared.sideSpacing,
                                           bottom: 0, right: Constants.shared.sideSpacing)
        layout.itemSize = CGSize(width: Constants.shared.pushItemWidth,
                                 height: Constants.shared.pushItemWidth / 4)
        layout.minimumLineSpacing = Constants.shared.minSpacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PushCollectionViewCell.self,
                                forCellWithReuseIdentifier: PushCollectionViewCell.cellId)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var dailyWeatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DailyTableViewCell.self,
                           forCellReuseIdentifier: DailyTableViewCell.cellId)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let tempLabel = MyLabel(color: .white, alignment: .right, textSize: 50)
    private let feelsLikeTemp = MyLabel(color: .white, textSize: 16)
    private let weatherImage = MyImageView(color: .white)
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.shared.blueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        setupNavigationBar()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
}

// MARK: - Private methods

extension MainWeatherViewController {
    
    private func updateUIWith(_ result: Result?) {
        
        guard let temp = result?.current?.tempToString else { return }
        guard let feelsLike = result?.current?.feelsLikeToString else { return }
        guard let imageString = result?.current?.weather?.first?.systemIconNameString else { return }
        
        tempLabel.text = temp
        feelsLikeTemp.text = "Ощущается как: \(feelsLike)"
        weatherImage.image = UIImage(systemName: imageString)
        
        hourlyWeatherCollectionView.reloadData()
        dailyWeatherTableView.reloadData()
    }
    
    private func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completion: @escaping (String) -> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addTextField { textField in
            let cities = ["Москва", "Дубай", "Париж", "Калифорния", "Токио"]
            textField.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Найти", style: .default) { action in
            
            let textField = alertController.textFields?.first
            guard let cityName = textField?.text, cityName != "" else { return }
            
            CoordinateAssistant.shared.getCoordinateFrom(cityName) { (coordinate, error) in
                guard let coord = coordinate else { return }
                let url = Constants.shared.getUrlStringFrom(coord.latitude, and: coord.longitude)
                completion(url)
            }
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(search)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func findCityWeather() {
        presentSearchAlertController(withTitle: "Введите название города", message: nil, style: .alert) { url in
            NetworkingManager.shared.fetchDataFrom(url) { [weak self] result in
                self?.result = result
                self?.updateUIWith(result)
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(pushCollectionView)
        view.addSubview(hourlyWeatherCollectionView)
        view.addSubview(dailyWeatherTableView)
        
        pushCollectionView.delegate = self
        pushCollectionView.dataSource = self
        
        view.addSubview(tempLabel)
        view.addSubview(feelsLikeTemp)
        view.addSubview(weatherImage)
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: Constants.shared.screenWidth),
            backgroundView.heightAnchor.constraint(equalToConstant: Constants.shared.screenHeight * 0.6)
        ])
        
        NSLayoutConstraint.activate([
            pushCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushCollectionView.centerYAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            pushCollectionView.widthAnchor.constraint(equalToConstant: Constants.shared.screenWidth),
            pushCollectionView.heightAnchor.constraint(equalToConstant: Constants.shared.screenWidth * 0.3)
        ])
        
        NSLayoutConstraint.activate([
            hourlyWeatherCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hourlyWeatherCollectionView.bottomAnchor.constraint(equalTo: pushCollectionView.topAnchor),
            hourlyWeatherCollectionView.widthAnchor.constraint(equalToConstant: Constants.shared.screenWidth),
            hourlyWeatherCollectionView.heightAnchor.constraint(equalToConstant: Constants.shared.screenWidth * 0.3)
        ])
        
        NSLayoutConstraint.activate([
            dailyWeatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyWeatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyWeatherTableView.topAnchor.constraint(equalTo: pushCollectionView.bottomAnchor),
            dailyWeatherTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -Constants.shared.minSpacing / 2),
            tempLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.shared.screenHeight * 0.2)
        ])
        
        NSLayoutConstraint.activate([
            weatherImage.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.shared.minSpacing / 2),
            weatherImage.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 65),
            weatherImage.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            feelsLikeTemp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelsLikeTemp.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: Constants.shared.minSpacing)
        ])
    }
    
    private func setupNavigationBar() {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.backgroundColor = Constants.shared.blueColor
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ",
                                                           style: .done,
                                                           target: nil,
                                                           action: nil)
        
        let barButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                        style: .done,
                                        target: self,
                                        action: #selector(findCityWeather))
        barButton.tintColor = .white
        navigationItem.rightBarButtonItem = barButton
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension MainWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pushCollectionView {
            return 2
        } else {
            return (result?.hourly?.count ?? 0) / 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pushCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PushCollectionViewCell.cellId, for: indexPath) as! PushCollectionViewCell
            
            cell.updateUIWith(indexPath.item)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.cellId, for: indexPath) as! HourlyCollectionViewCell
            
            let hourlyWeather = result?.hourly?[indexPath.item]
            cell.configurateWith(hourlyWeather, and: indexPath.item)
            
            return cell
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension MainWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        result?.daily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.cellId, for: indexPath) as! DailyTableViewCell
        
        let dailyWeather = result?.daily?[indexPath.row]
        cell.configurateWith(dailyWeather, and: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = WeatherDetailsViewController()
        let dailyWeather = result?.daily?[indexPath.row]
        detailsVC.dailyWeather = dailyWeather
            
        navigationController?.pushViewController(detailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        45
    }
}

// MARK: - CLLocationManagerDelegate

extension MainWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location  = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        DispatchQueue.global().async {
            let urlString = Constants.shared.getUrlStringFrom(latitude, and: longitude)
            NetworkingManager.shared.fetchDataFrom(urlString) { [weak self] result in
                self?.result = result
                self?.updateUIWith(result)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
