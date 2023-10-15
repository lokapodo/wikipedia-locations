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
    
    init(name: String?, lat: Double, lon: Double) {
        self.name = name
        self.lat = lat
        self.lon = lon
    }
}

let testLocation1 = Location(name: "Something", lat: 50.3547498, lon: 30.8339215)
let testLocation2 = Location(name: "Copenhagen", lat: 55.6713442, lon: 12.523785)
let testLocation3 = Location(name: "Amsterdam", lat: 52.3547498, lon: 4.8339215)

