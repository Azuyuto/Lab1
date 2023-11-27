import SwiftUI

struct ListView: View {
    @State private var refreshFlag = false
    @StateObject private var store = BuildingStore()
    @Binding var buildings: [BuildingModel]
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            List(buildings, id: \.id) { building in
                NavigationLink(destination: BuildingView(building: building)) {
                    CardView(building: building)
                }
                .listRowBackground(building.theme.mainColor)
            }
            .navigationTitle("Budynki AGH")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {}) {
                        Image(systemName: "star")
                    }
                    .accessibilityLabel("New Scrum")
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        fetchData()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                    .help("Podwójne kliknięcie = pobranie danych od nowa")
                }
            }
        }
    }
    
    func fetchData() {
        Task {
            do {
                _ = try await store.fetchDataFromAPI()
                buildings = store.buildings
            } catch {
                print("Error: \(error)")
            }
        }
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(buildings: .constant(BuildingModel.sampleData))
    }
}
