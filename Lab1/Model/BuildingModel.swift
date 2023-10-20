import Foundation
import MapKit

struct BuildingModel: Identifiable {
    var id: UUID
    var symbol: String
    var name: String
    var image: String
    var address: String
    var description: String
    var wifi: Bool
    var wheelChair: AvailableOptionEnum
    var shape: MKPolygon
    var type: String
    var theme: Theme
    
    init(id: UUID = UUID(), symbol: String, name: String, image: String, address: String, description: String, wifi: Bool, wheelChair: AvailableOptionEnum,
         shape: MKPolygon, type: String, theme: Theme) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.address = address
        self.description = description
        self.wifi = wifi
        self.wheelChair = wheelChair
        self.shape = shape
        self.type = type
        self.theme = theme
    }
}

enum AvailableOptionEnum {
    case Yes
    case Limited
    case No
}

extension BuildingModel {
    static let sampleData: [BuildingModel] =
    [
        BuildingModel(symbol: "Budynek U-1",
                      name: "Biblioteka Główna AGH",
                      image: "...",
                      address: "Aleja Adama Mickiewicza 30",
                      description: "Biblioteka powstała w roku akademickim 1921/22, powołana przez Senacką Komisję Biblioteczną na Ogólnym Zebraniu Profesorów 12 grudnia 1921 r. Komisja odpowiadała za organizację i rozwój Biblioteki, wyznaczała kierunki jej działania, czuwała nad profilem gromadzonych zbiorów i zabiegała o pozyskiwanie darów.",
                      wifi: true,
                      wheelChair: AvailableOptionEnum.Yes,
                      shape: MKPolygon(coordinates:[
                        CLLocationCoordinate2DMake(50.0655761, 19.9211358),
                        CLLocationCoordinate2DMake(50.0659194, 19.9212776),
                        CLLocationCoordinate2DMake(50.0658184, 19.9218710),
                        CLLocationCoordinate2DMake(50.0654751, 19.9217292)
                      ], count: 4),
                      type: "library",
                      theme: .lavender),
        BuildingModel(symbol: "Budynek D-9",
                      name: "Nawiedzony budynek, uuu",
                      image: "...",
                      address: "Aleja Adama Mickiewicza 40",
                      description: "Dziwny budynek, duchy tam strasza.",
                      wifi: false,
                      wheelChair: AvailableOptionEnum.No,
                      shape: MKPolygon(coordinates:[
                        CLLocationCoordinate2DMake(50.0678058, 19.9095386),
                        CLLocationCoordinate2DMake(50.0677089, 19.9101869),
                        CLLocationCoordinate2DMake(50.0675934, 19.9101476),
                        CLLocationCoordinate2DMake(50.0676912, 19.9095019)
                      ], count: 4),
                      type: "university",
                      theme: .yellow),
        BuildingModel(symbol: "Budynek D-1",
                      name: "Czekoladka",
                      image: "...",
                      address: "Władysława Reymonta 9",
                      description: "Budynek ma 5 kondygnacji nadziemnych oraz jedną kondygnacje podziemną. W rzucie ma kształt litery C. Większość kondygnacji jest dostępna dla osób z niepełnosprawnościami fizycznymi (z wyłączeniem poddasza, na którym znajdują się pomieszczenia techniczne). W holu zlokalizowany jest podnośnik schodowy umożliwiający wejście na wyższy parter. Uruchomienie urządzenia wymaga pomocy portiera. Komunikację między piętrami zapewnia winda dostosowana dla osób z niepełnosprawnościami.",
                      wifi: true,
                      wheelChair: AvailableOptionEnum.Limited,
                      shape: MKPolygon(coordinates:[
                        CLLocationCoordinate2DMake(50.0646746, 19.9194159),
                        CLLocationCoordinate2DMake(50.0648984, 19.9194980),
                        CLLocationCoordinate2DMake(50.0648237, 19.9200091),
                        CLLocationCoordinate2DMake(50.0645993, 19.9199271)
                      ], count: 4),
                      type: "university",
                      theme: .blue),
    ]
}
