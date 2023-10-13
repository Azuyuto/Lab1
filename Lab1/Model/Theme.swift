import SwiftUI


enum Theme: String {
    case lavender
    case purple
    case yellow
    
    var accentColor: Color {
        switch self {
        case .lavender, .yellow: return .black
        case .purple: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
}
