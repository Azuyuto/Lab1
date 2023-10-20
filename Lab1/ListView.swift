import SwiftUI


struct ScrumsView: View {
    let buildings: [BuildingModel]
    
    var body: some View {
        List(buildings, id: \.name) { building in
            CardView(building: building)
                .listRowBackground(building.theme.mainColor)
        }
    }
}


struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(buildings: BuildingModel.sampleData)
    }
}
