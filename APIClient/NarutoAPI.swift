//
//  LeagueAPI.swift
//  Practice
//
//  Created by Tsering Lama on 12/24/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

struct NarutoAPI {
    
    static func getNinjas(completionHandler: @escaping (Result<[Ninjas], AppError>) -> () ) {
        
        let narutoEndpoint = "https://api.jikan.moe/v3/manga/11/characters"
        
        guard let url = URL(string: narutoEndpoint) else {
            completionHandler(.failure(.badURL(narutoEndpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completionHandler(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let narutoData = try JSONDecoder().decode(Naruto.self, from: data)
                    var narutoArr = [Ninjas]()
                    let narutoNinjas = narutoData.characters
                    
                    for ninjas in narutoNinjas {
                        narutoArr.append(ninjas)
                    }
                    completionHandler(.success(narutoArr))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
