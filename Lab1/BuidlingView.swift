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
        ScrollView{
            VStack(alignment: .leading) {
                Image(.building)
                    .resizable()
                    .aspectRatio(2/1, contentMode: .fit)
                    .cornerRadius(10)
                Text(building.symbol)
                    .font(.system(size: 30, weight: .bold))
                Text("(" + building.name + ")")
                    .font(.system(size: 20))
                HStack {
                    Text(building.address)
                        .font(.system(size: 14))
                    Spacer()
                    if(building.wifi)
                    {
                        Image(systemName: "wifi")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                    if(building.wheelChair != AvailableOptionEnum.No)
                    {
                        Image(systemName: "figure.roll")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                            .tint(building.wheelChair == AvailableOptionEnum.Yes ? .black : .gray)
                    }
                }
                Text(building.description)
                    .font(.system(size: 12))
                    .padding(.top, 10)
                MyMap()
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
