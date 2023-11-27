import Foundation
import MapKit

struct BuildingModel: Identifiable, Codable {
    var id = UUID()
    var symbol: String
    var name: String
    var wifi: Bool
    var wheelchair: AvailableOptionEnum
    var floors: Int
    var street: String
    var houseNumber: String
    var postcode: String
    var city: String
    var description: String
    var type: String
    var polygon: [PolygonModel]
    var imageURL: String
    var theme: Theme
    
    private enum CodingKeys: String, CodingKey {
        case symbol, name, wifi, wheelchair, floors, street, houseNumber, postcode, city, description, type, polygon, imageURL
    }
    
    init(symbol: String, name: String, wifi: Bool, wheelchair: AvailableOptionEnum, floors: Int, street: String, houseNumber: String, postcode: String, city: String, description: String, type: String, polygon: [PolygonModel], imageURL: String) {
        self.symbol = symbol
        self.name = name
        self.wifi = wifi
        self.wheelchair = wheelchair
        self.floors = floors
        self.street = street
        self.houseNumber = houseNumber
        self.postcode = postcode
        self.city = city
        self.description = description
        self.type = type
        self.polygon = polygon
        self.imageURL = imageURL
        self.theme = .blue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(String.self, forKey: .symbol)
        if let tryName = try? container.decode(String.self, forKey: .name)
        {
            name = tryName
        } else {
            name = "???"
        }
        wifi = try container.decode(Bool.self, forKey: .wifi)
        wheelchair = try container.decode(AvailableOptionEnum.self, forKey: .wheelchair)
        floors = try container.decode(Int.self, forKey: .floors)
        street = try container.decode(String.self, forKey: .street)
        if let tryHouseNumber = try? container.decode(String.self, forKey: .houseNumber) {
            houseNumber = tryHouseNumber
        } else {
            houseNumber = "???"
        }
        postcode = try container.decode(String.self, forKey: .postcode)
        if let tryCity = try? container.decode(String.self, forKey: .city) {
            city = tryCity
        } else {
            city = "???"
        }
        if let tryDescription = try? container.decode(String.self, forKey: .description) {
            description = tryDescription
        } else {
            description = "???"
        }
        type = try container.decode(String.self, forKey: .type)
        polygon = try container.decode([PolygonModel].self, forKey: .polygon)
        if let tryImageURL = try? container.decode(String.self, forKey: .imageURL)
        {
            imageURL = tryImageURL
        } else {
            imageURL = "https://www.agh.edu.pl/repozytoria/__processed__/0/8/csm_agh_znak_wielobarwn_bez_nazwy_d4b64672bc.jpg"
        }
        theme = Theme.allCases.randomElement()!
    }
}

enum AvailableOptionEnum : String, Codable {
    case yes = "yes"
    case limited = "limited"
    case no = "no"
}

func convertPolygonToBuildingShape(polygons: [PolygonModel]) -> [CLLocationCoordinate2D] {
    var buildingShape: [CLLocationCoordinate2D] = []

    for polygon in polygons {
        let coordinate = CLLocationCoordinate2D(latitude: polygon.lat, longitude: polygon.lon)
        buildingShape.append(coordinate)
    }

    return buildingShape
}

func getCenter(polygons: [PolygonModel]) -> CLLocationCoordinate2D {
    var sumLat = 0.0
    var sumLon = 0.0
    for polygon in polygons {
        sumLat = sumLat + polygon.lat
        sumLon = sumLon + polygon.lon
    }

    return CLLocationCoordinate2D(latitude: sumLat / Double(polygons.count), longitude: sumLon / Double(polygons.count))
}

extension BuildingModel {
    static let sampleData: [BuildingModel] =
    [
        BuildingModel(symbol: "Budynek U-1",
                      name: "Biblioteka Główna AGH",
                      wifi: true,
                      wheelchair: AvailableOptionEnum.yes,
                      floors: 10,
                      street: "Aleja Adama Mickiewicza",
                      houseNumber: "30",
                      postcode: "30-085",
                      city: "Kraków",
                      description: "Biblioteka powstała w roku akademickim 1921/22, powołana przez Senacką Komisję Biblioteczną na Ogólnym Zebraniu Profesorów 12 grudnia 1921 r. Komisja odpowiadała za organizację i rozwój Biblioteki, wyznaczała kierunki jej działania, czuwała nad profilem gromadzonych zbiorów i zabiegała o pozyskiwanie darów.",
                      type: "library",
                      polygon: [
                        PolygonModel(lat: 50.0655761, lon: 19.9211358),
                        PolygonModel(lat: 50.0659194, lon: 19.9212776),
                        PolygonModel(lat: 50.0658184, lon: 19.9218710),
                        PolygonModel(lat: 50.0654751, lon: 19.9217292)
                      ],
                      imageURL: "..."
                      //,theme: .lavender
                      ),
        BuildingModel(symbol: "Budynek D-9",
                      name: "Nawiedzony budynek, uuu",
                      wifi: false,
                      wheelchair: AvailableOptionEnum.no,
                      floors: 10,
                      street: "Aleja Adama Mickiewicza",
                      houseNumber: "40",
                      postcode: "30-085",
                      city: "Kraków",
                      description: "Dziwny budynek, duchy tam strasza.",
                      type: "university",
                      polygon: [
                        PolygonModel(lat: 50.0678058, lon: 19.9095386),
                        PolygonModel(lat: 50.0677089, lon: 19.9101869),
                        PolygonModel(lat: 50.0675934, lon: 19.9101476),
                        PolygonModel(lat: 50.0676912, lon: 19.9095019)
                      ],
                      imageURL: "..."
                      //,theme: .yellow
                      ),
        BuildingModel(symbol: "Budynek D-1",
                      name: "Czekoladka",
                      wifi: true,
                      wheelchair: AvailableOptionEnum.limited,
                      floors: 10,
                      street: "Władysława Reymonta",
                      houseNumber: "9",
                      postcode: "30-085",
                      city: "Kraków",
                      description: "Budynek ma 5 kondygnacji nadziemnych oraz jedną kondygnacje podziemną. W rzucie ma kształt litery C. Większość kondygnacji jest dostępna dla osób z niepełnosprawnościami fizycznymi (z wyłączeniem poddasza, na którym znajdują się pomieszczenia techniczne). W holu zlokalizowany jest podnośnik schodowy umożliwiający wejście na wyższy parter. Uruchomienie urządzenia wymaga pomocy portiera. Komunikację między piętrami zapewnia winda dostosowana dla osób z niepełnosprawnościami.",
                      type: "university",
                      polygon: [
                        PolygonModel(lat: 50.0646746, lon: 19.9194159),
                        PolygonModel(lat: 50.0648984, lon: 19.9194980),
                        PolygonModel(lat: 50.0648237, lon: 19.9200091),
                        PolygonModel(lat: 50.0645993, lon: 19.9199271)
                      ],
                      imageURL: "..."
                      //,theme: .blue
                     ),
    ]
}
