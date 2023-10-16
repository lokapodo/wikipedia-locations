//
//  Location.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import Foundation

struct Location: Decodable, Equatable {
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
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.lat == rhs.lat && lhs.lon == rhs.lon && lhs.name == rhs.name
    }
}
