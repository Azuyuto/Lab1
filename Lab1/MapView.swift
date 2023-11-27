//
//  MapView.swift
//  Lab1
//
//  Created by Dawid on 27/11/2023.
//

import Foundation
import SwiftUI
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapView: View {
    @StateObject private var store = BuildingStore()
    @Binding var buildings: [BuildingModel]
    
    var body: some View {
        Map()
        {
            ForEach(buildings) { building in
                MapPolygon(coordinates: convertPolygonToBuildingShape(polygons: building.polygon))
                    .stroke(.black)
                    .foregroundStyle(building.theme.mainColor)
            }
            ForEach(buildings) { building in
                Annotation(building.symbol, coordinate: getCenter(polygons: building.polygon))
                {
                    Text(building.symbol)
                        .font(.system(size: 12))
                }
            }
        }
        .mapControls{
            MapUserLocationButton()
        }
        .onAppear(){
            CLLocationManager().requestWhenInUseAuthorization()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(buildings: .constant(BuildingModel.sampleData))
    }
}
