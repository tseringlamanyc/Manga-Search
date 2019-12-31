//
//  Champions.swift
//  Practice
//
//  Created by Tsering Lama on 12/24/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

struct Naruto: Codable {
    let requestHash: String
    let requestCached: Bool
    let requestCacheExpiry: Int
    let characters: [Ninjas]

    enum CodingKeys: String, CodingKey {
        case requestHash = "request_hash"
        case requestCached = "request_cached"
        case requestCacheExpiry = "request_cache_expiry"
        case characters
    }
}

// MARK: - Character
struct Ninjas: Codable {
    let malID: Int
    let url: String
    let imageURL: String
    let name: String
    let role: Role

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url
        case imageURL = "image_url"
        case name, role
    }
}

enum Role: String, Codable {
    case main = "Main"
    case supporting = "Supporting"
}
