import Foundation
import SofaAcademic

final class LeagueMatchesDataLoader {
    
    private let dataSource: Homework3DataSource
    
    init(dataSource: Homework3DataSource = Homework3DataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchEvents(for sport: SportType) -> [Event] {
        switch sport {
        case .football:
            return dataSource.events()
        case .basketball:
            return dataSource.events()
        case .americanFootball:
            return dataSource.events()
        }
    }
}
