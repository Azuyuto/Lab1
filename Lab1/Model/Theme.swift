import SwiftUI


enum Theme: String {
    case lavender
    case blue
    case yellow
    
    var accentColor: Color {
        switch self {
        case .lavender, .yellow: return .black
        case .blue: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
}
