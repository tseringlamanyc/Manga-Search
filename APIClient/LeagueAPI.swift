//
//  LeagueAPI.swift
//  Practice
//
//  Created by Tsering Lama on 12/24/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

struct LeagueAPI {
    
    static func getChampions(completionHandler: @escaping (Result<Champions, AppError>) -> () ) {
        
        let leagueEndpoint = "https://ddragon.leagueoflegends.com/cdn/9.24.2/data/en_US/champion.json"
        
        guard let url = URL(string: leagueEndpoint) else {
            completionHandler(.failure(.badURL(leagueEndpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
       print("Hello")
        
    }
}
