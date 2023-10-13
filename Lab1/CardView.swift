import SwiftUI
import MapKit

struct CardView: View {
    let building: BuildingModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(building.symbol)
                .font(.headline)
            Spacer()
            HStack {
                Text(building.name)
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
            .font(.caption)
        }
        .padding()
        .foregroundColor(building.theme.accentColor)
    }
}


struct CardView_Previews: PreviewProvider {
    static var building = BuildingModel.sampleData[0]
    static var previews: some View {
        CardView(building: building)
            .background(building.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
