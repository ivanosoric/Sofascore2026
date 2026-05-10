import Foundation
import SofaAcademic

final class LeagueMatchesDataLoader {
    
    private let apiClient = APIClient()
    
    func fetchEvents(
        for sport: SportType,
        completion: @escaping ([Event]) -> Void
    ) {
        apiClient.getEvents(sportSlug: sport.slug) { result in
            switch result {
            case .success(let apiEvents):
                let events = apiEvents.map { self.mapEvent($0) }
                completion(events)
                
            case .failure(let error):
                print("API error:", error)
                completion([])
            }
        }
    }
}

private extension LeagueMatchesDataLoader {
    
    func mapEvent(_ apiEvent: APIEvent) -> Event {
        Event(
            id: apiEvent.id,
            homeTeam: mapTeam(apiEvent.homeTeam),
            awayTeam: mapTeam(apiEvent.awayTeam),
            league: mapLeague(apiEvent.league),
            status: mapStatus(apiEvent.status),
            startTimestamp: apiEvent.startTimestamp,
            homeScore: apiEvent.homeScore,
            awayScore: apiEvent.awayScore
        )
    }
    
    func mapTeam(_ apiTeam: APITeam) -> Team {
        Team(
            id: apiTeam.id,
            name: apiTeam.name,
            logoUrl: apiTeam.logoUrl
        )
    }
    
    func mapLeague(_ apiLeague: APILeague?) -> League? {
        guard let apiLeague else {
            return nil
        }
        
        return League(
            id: apiLeague.id,
            name: apiLeague.name,
            country: Country(
                id: 0,
                name: apiLeague.country?.name ?? ""
            ),
            logoUrl: apiLeague.logoUrl
        )
    }
    
    func mapStatus(_ status: String) -> EventStatus {
        switch status {
        case "IN_PROGRESS":
            return .inProgress
        case "HALFTIME":
            return .halftime
        case "FINISHED":
            return .finished
        case "NOT_STARTED":
            return .notStarted
        default:
            return .notStarted
        }
    }
}
