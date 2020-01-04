//
//  LeagueAPI.swift
//  Practice
//
//  Created by Tsering Lama on 12/24/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

struct mangaAPI {
    
    static func getMangas(mangaNum: Int, completionHandler: @escaping (Result<[Ninjas], AppError>) -> () ) {
        
        let mangaEndpoint = "https://api.jikan.moe/v3/manga/\(mangaNum)/characters"
        
        guard let url = URL(string: mangaEndpoint) else {
            completionHandler(.failure(.badURL(mangaEndpoint)))
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
