import Foundation

enum SportType: Int, CaseIterable {
    case football
    case basketball
    case americanFootball

    var title: String {
        switch self {
        case .football:
            return "Football"
        case .basketball:
            return "Basketball"
        case .americanFootball:
            return "Am. Football"
        }
    }

    var iconSystemName: String {
        switch self {
        case .football:
            return "soccerball"
        case .basketball:
            return "basketball"
        case .americanFootball:
            return "football"
        }
    }
}
