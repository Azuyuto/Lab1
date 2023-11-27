import SwiftUI


enum Theme: String, CaseIterable, Identifiable, Codable {
    case lavender
    case blue
    case yellow
    case orange
    case red
    case brown
    case green
    case pink
    
    var accentColor: Color {
        switch self {
        case .lavender, .yellow, .pink, .green, .orange: return .black
        case .blue, .brown, .red: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}
