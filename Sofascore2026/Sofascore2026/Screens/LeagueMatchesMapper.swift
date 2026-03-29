import Foundation
import UIKit
import SofaAcademic

final class LeagueMatchesMapper {
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy."
        return formatter
    }()
    
    func makeSections(from events: [Event]) -> [LeagueSectionViewModel] {
        let sortedEvents = events.sorted { $0.startTimestamp < $1.startTimestamp }
        
        let groupedEvents = Dictionary(grouping: sortedEvents) { event in
            event.league?.id ?? -1
        }
        
        let sections = groupedEvents.compactMap { _, leagueEvents in
            makeSection(from: leagueEvents)
        }
        
        return sections.sorted {
            $0.headerViewModel.leagueName < $1.headerViewModel.leagueName
        }
    }
}

private extension LeagueMatchesMapper {
    
    func makeSection(from events: [Event]) -> LeagueSectionViewModel? {
        guard
            let firstEvent = events.first,
            let league = firstEvent.league
        else {
            return nil
        }
        
        let sortedLeagueEvents = events.sorted { $0.startTimestamp < $1.startTimestamp }
        
        let headerViewModel = LeagueHeaderViewModel(
            countryName: league.country?.name ?? "",
            leagueName: league.name,
            logoURL: makeURL(from: league.logoUrl)
        )
        
        let rowViewModels = sortedLeagueEvents.map { makeMatchRowViewModel(from: $0) }
        
        return LeagueSectionViewModel(
            headerViewModel: headerViewModel,
            matchRowViewModels: rowViewModels
        )
    }
    
    func makeMatchRowViewModel(from event: Event) -> MatchRowViewModel {
        let timeText = formattedTime(from: event.startTimestamp)
        let homeScoreText = scoreText(from: event.homeScore)
        let awayScoreText = scoreText(from: event.awayScore)
        
        let detailsViewModel = EventDetailsViewModel(
            tournamentText: tournamentText(from: event),
            homeTeamName: event.homeTeam.name,
            awayTeamName: event.awayTeam.name,
            homeTeamLogoURL: makeURL(from: event.homeTeam.logoUrl),
            awayTeamLogoURL: makeURL(from: event.awayTeam.logoUrl),
            dateText: formattedDate(from: event.startTimestamp),
            timeText: timeText
        )
        
        return MatchRowViewModel(
            timeText: timeText,
            statusText: statusText(for: event.status),
            statusColor: statusColor(for: event.status),
            homeTeamName: event.homeTeam.name,
            awayTeamName: event.awayTeam.name,
            homeLogoURL: makeURL(from: event.homeTeam.logoUrl),
            awayLogoURL: makeURL(from: event.awayTeam.logoUrl),
            homeTeamScore: homeScoreText,
            awayTeamScore: awayScoreText,
            scoreColor: scoreColor(for: event.status),
            eventDetailsViewModel: detailsViewModel
        )
    }
    
    func tournamentText(from event: Event) -> String {
        let country = event.league?.country?.name ?? ""
        let league = event.league?.name ?? ""
        
        if country.isEmpty && league.isEmpty {
            return "Football"
        }
        
        if league.isEmpty {
            return "Football, \(country)"
        }
        
        return "Football, \(country), \(league)"
    }
    
    func makeURL(from string: String?) -> URL? {
        guard let string else { return nil }
        return URL(string: string)
    }
    
    func formattedTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return timeFormatter.string(from: date)
    }
    
    func formattedDate(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return dateFormatter.string(from: date)
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
