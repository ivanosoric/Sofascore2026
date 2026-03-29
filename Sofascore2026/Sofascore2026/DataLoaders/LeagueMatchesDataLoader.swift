import Foundation
import UIKit
import SofaAcademic

final class LeagueMatchesDataLoader {
    
    private let dataSource: Homework3DataSource
    
    init(dataSource: Homework3DataSource = Homework3DataSource()) {
        self.dataSource = dataSource
    }
    
    func makeSections(for sport: SportType) -> [LeagueSectionViewModel] {
        let events = events(for: sport)
            .sorted { $0.startTimestamp < $1.startTimestamp }
        
        let groupedEvents = Dictionary(grouping: events) { event in
            event.league?.id ?? -1
        }
        
        let sections = groupedEvents.compactMap { _, leagueEvents -> LeagueSectionViewModel? in
            guard
                let firstEvent = leagueEvents.first,
                let league = firstEvent.league
            else {
                return nil
            }
            
            let sortedLeagueEvents = leagueEvents.sorted { $0.startTimestamp < $1.startTimestamp }
            
            let headerViewModel = LeagueHeaderViewModel(
                countryName: league.country?.name ?? "",
                leagueName: league.name,
                logoURL: makeURL(from: league.logoUrl)
            )
            
            let rowViewModels = sortedLeagueEvents.map { event in
                MatchRowViewModel(
                    timeText: formattedTime(from: event.startTimestamp),
                    statusText: statusText(for: event.status),
                    statusColor: statusColor(for: event.status),
                    homeTeamName: event.homeTeam.name,
                    awayTeamName: event.awayTeam.name,
                    homeLogoURL: makeURL(from: event.homeTeam.logoUrl),
                    awayLogoURL: makeURL(from: event.awayTeam.logoUrl),
                    homeTeamScore: scoreText(from: event.homeScore),
                    awayTeamScore: scoreText(from: event.awayScore),
                    scoreColor: scoreColor(for: event.status)
                )
            }
            
            return LeagueSectionViewModel(
                headerViewModel: headerViewModel,
                matchRowViewModels: rowViewModels
            )
        }
        
        return sections.sorted {
            $0.headerViewModel.leagueName < $1.headerViewModel.leagueName
        }
    }
}

private extension LeagueMatchesDataLoader {
    
    func events(for sport: SportType) -> [Event] {
        switch sport {
        case .football:
            return dataSource.events()
        case .basketball:
            return dataSource.events()
        case .americanFootball:
            return dataSource.events()
        }
    }
    
    func makeURL(from string: String?) -> URL? {
        guard let string else { return nil }
        return URL(string: string)
    }
    
    func formattedTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func statusText(for status: EventStatus) -> String {
        switch status {
        case .finished:
            return AppStrings.finished
        case .halftime:
            return AppStrings.halftime
        case .inProgress:
            return AppStrings.live
        case .notStarted:
            return AppStrings.notStarted
        }
    }
    
    func statusColor(for status: EventStatus) -> UIColor {
        switch status {
        case .inProgress:
            return AppColors.accent
        case .finished, .halftime, .notStarted:
            return AppColors.secondaryText
        }
    }
    
    func scoreText(from score: Int?) -> String {
        guard let score else { return AppStrings.noScore }
        return String(score)
    }
    
    func scoreColor(for status: EventStatus) -> UIColor {
        switch status {
        case .inProgress:
            return AppColors.accent
        case .finished, .halftime, .notStarted:
            return AppColors.primaryText
        }
    }
}
