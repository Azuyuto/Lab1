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

struct BuildingView: View {
    let building: BuildingModel
    var body: some View {
        let imageURL = URL(string: building.imageURL)!
        ScrollView{
            VStack(alignment: .leading) {
                AsyncImage(url: imageURL){
                    phase in
                       switch phase {
                       case .empty:
                           ProgressView()
                       case .success(let image):
                           image
                               .resizable()
                               .aspectRatio(2/1, contentMode: .fit)
                               .cornerRadius(10)
                       case .failure:
                           Image(systemName: "exclamationmark.triangle")
                               .resizable()
                               .scaledToFit()
                               .foregroundColor(.red)
                       @unknown default:
                           fatalError()
                       }
                }
                Text(building.symbol)
                    .font(.system(size: 30, weight: .bold))
                Text("(" + building.name + ")")
                    .font(.system(size: 20))
                HStack {
                    Text(building.street + " " + building.houseNumber)
                        .font(.system(size: 14))
                    Spacer()
                    if(building.wifi)
                    {
                        Image(systemName: "wifi")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                    if(building.wheelchair != AvailableOptionEnum.no)
                    {
                        Image(systemName: "figure.roll")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                            .tint(building.wheelchair == AvailableOptionEnum.yes ? .black : .gray)
                    }
                }
                Text(building.description)
                    .font(.system(size: 12))
                    .padding(.top, 10)
                let buildingShape = convertPolygonToBuildingShape(polygons: building.polygon)
                let mapSize = UIScreen.main.bounds.width - 20
                Map{
                    MapPolygon(coordinates: buildingShape)
                        .stroke(.blue, lineWidth: 2)
                }
                .frame(width: mapSize, height: mapSize)
            }
            .padding(10)
        }
    }
}

struct BuildingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BuildingView(building: BuildingModel.sampleData[0])
        }
    }
}
