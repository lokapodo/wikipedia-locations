//
//  Location.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import Foundation

struct Location: Decodable {
    let name: String?
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case lat
        case lon = "long"
    }
    
    init(name: String? = nil, lat: Double, lon: Double) {
        self.name = name
        self.lat = lat
        self.lon = lon
    }
}

struct LocationsWrapper: Decodable {
    let locations: [Location]
}
