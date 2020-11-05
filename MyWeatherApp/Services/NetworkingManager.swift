//
//  NetworkingManager.swift
//  MyWeatherApp
//
//  Created by Денис on 03.11.2020.
//  Copyright © 2020 Denis Khudoyarov. All rights reserved.
//

import Foundation
import  Alamofire

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func fetchDataFrom(_ urlString: String, with completion: @escaping (Result) -> ()) {
        AF.request(urlString)
            .validate()
            .responseDecodable(of: Result.self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    DispatchQueue.main.async {
                        completion(value)
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}
