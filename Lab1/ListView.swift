import SwiftUI

struct ListView: View {
    let buildings: [BuildingModel]
    
    var body: some View {
        NavigationStack {
            List(buildings, id: \.name) { building in
                NavigationLink(destination: BuildingView(building: building)) {
                    CardView(building: building)
                }
                .listRowBackground(building.theme.mainColor)
            }
            .navigationTitle("Budynki AGH")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(buildings: BuildingModel.sampleData)
    }
}
