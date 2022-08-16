//
//  APIEndpoint.swift
//  MagicGathering
//
//  Created by Nguyễn Việt on 08/07/2022.
//

import Foundation

let API_SCHEME = "https"
let API_HOST = "api.scryfall.com"

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    enum SortingCards: String {
        case name
        case set
        case released
        case rarity
        case color
        case usd
        case tix
        case eur
        case cmc
        case power
        case toughness
        case edhrec
        case penny
        case artist
        case review
    }
    
    /**
     - Search cards
    */
    static func searchCard(query: String, sorting: SortingCards = .name) -> Endpoint {
        return Endpoint(
            path: "/cards/search",
            queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "sort", value: sorting.rawValue)
            ]
        )
    }
    
    /**
     - Get card detail by id
    */
    static func cardDetail(id: String) -> Endpoint {
        return Endpoint(
                path: "/cards/\(id)",
                queryItems: []
        )
    }
    
    static func creatureTypes() -> Endpoint  {
        return Endpoint(path: "/catalog/creature-types", queryItems: [])
    }
    
    
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = API_SCHEME
        components.host = API_HOST
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}
