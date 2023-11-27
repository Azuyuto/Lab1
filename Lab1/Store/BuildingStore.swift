//
//  BuildingStore.swift
//  Lab1
//
//  Created by Dawid on 27/11/2023.
//

import Foundation

struct APIResponse: Codable {
    let buildings: [BuildingModel]
}

class BuildingStore: ObservableObject {
    @Published var buildings: [BuildingModel] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("agh-buildings.data")
    }
    
    func load() async throws {
        let task = Task<[BuildingModel], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return try await fetchDataFromAPI()
            }
            let buildings = try JSONDecoder().decode([BuildingModel].self, from: data)
            return buildings
        }
        let buildings = try await task.value
        DispatchQueue.main.async {
            self.buildings = buildings
        }
    }

    func save(buildings: [BuildingModel]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(buildings)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    func fetchDataFromAPI() async throws -> [BuildingModel] {
        guard let url = URL(string: "https://tools.sokoloowski.pl/pum-api") else { return [] }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode([BuildingModel].self, from: data)
                    DispatchQueue.main.async {
                        self.buildings = results
                    }
                } catch let error {
                    print("Error: \(error)")
                }

            }
        }.resume()
        try await save(buildings: self.buildings)
        return self.buildings
    }
}
