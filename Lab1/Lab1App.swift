//
//  Lab1App.swift
//  Lab1
//
//  Created by Guest User on 06/10/2023.
//

import SwiftUI

@main
struct Lab1App: App {
    @StateObject private var store = BuildingStore()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ListView(buildings: $store.buildings)
                    .task {
                        do {
                            try await store.load()
                        } catch {
                            print(error)
                            fatalError(error.localizedDescription)
                        }
                    }
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Lista")
                    }
                MapView(buildings: $store.buildings)
                    .task {
                        do {
                            try await store.load()
                        } catch {
                            print(error)
                            fatalError(error.localizedDescription)
                        }
                    }
                    .tabItem {
                        Image(systemName: "map")
                        Text("Mapa")
                    }
            }
        }
    }
}
