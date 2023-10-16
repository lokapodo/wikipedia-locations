//
//  LocationError.swift
//  WikipediaLocations
//
//  Created by Loka on 16.10.2023.
//

import Foundation

enum LocationError: Error, LocalizedError {
    case wrongLatLonFormat
    
    var localizedDescription: String {
        switch self {
        case .wrongLatLonFormat:
            return "Invalid latitude and longitude format. Please enter it in the correct format." // FIXME: update message
        }
    }
}
