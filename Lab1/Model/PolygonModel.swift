//
//  PolygonModel.swift
//  Lab1
//
//  Created by Dawid on 27/11/2023.
//

import Foundation

struct PolygonModel: Codable {
    let lat: Double
    let lon: Double

    init(lat: Double, lon: Double) {
        self.lat = lat;
        self.lon = lon;
    }
}

