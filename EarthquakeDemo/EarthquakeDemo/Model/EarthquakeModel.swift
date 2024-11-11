//
//  Untitled.swift
//  EarthquakeDemo
//
//  Created by ychen327 on 2024/11/10.
//

import Foundation
import CoreLocation
struct EarthquakeResponse: Decodable {
    let features: [Feature]
}

struct Feature: Identifiable, Decodable {
    let id: String
    let properties: Properties
    let geometry: Geometry

    struct Properties: Decodable {
        let place: String?
        let mag: Double?
        let time: Int?
    }

    struct Geometry: Decodable {
        let coordinates: [Double] // [longitude, latitude, depth]
        
        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
        }
    }
}
