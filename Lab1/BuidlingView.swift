//
//  ContentView.swift
//  Lab1
//
//  Created by Guest User on 06/10/2023.
//

import SwiftUI
import MapKit

struct MyMap: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.0672, longitude: 19.9141),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    let mapSize = UIScreen.main.bounds.width - 20
    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear {
                // Możesz tu dodać kod do uaktualnienia regionu na początku
            }
            .frame(width: mapSize, height: mapSize)
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Image(.building)
                    .resizable()
                    .aspectRatio(2/1, contentMode: .fit)
                    .cornerRadius(10)
                Text("Swiatynia AGH")
                    .font(.system(size: 36, weight: .bold))
                Text("(Budynek Glowny)")
                    .font(.system(size: 24))
                HStack {
                    Text("ul. 3 maja")
                        .font(.system(size: 16))
                    Spacer()
                    Image(systemName: "wifi")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Image(systemName: "parkingsign")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Image(systemName: "figure.roll")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .tint(.black)
                }
                Text("      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .font(.system(size: 12))
                    .padding(.top, 10)
                MyMap()
            }
            .padding(10)
        }
    }
}

#Preview {
    ContentView()
}