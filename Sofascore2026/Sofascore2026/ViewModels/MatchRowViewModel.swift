import UIKit
import Foundation

struct MatchRowViewModel {
    let timeText: String
    let statusText: String
    let statusColor: UIColor
    
    let homeTeamName: String
    let awayTeamName: String
    
    let homeLogoURL: URL?
    let awayLogoURL: URL?
    
    let homeTeamScore: String
    let awayTeamScore: String
    let scoreColor: UIColor
    
    let eventDetailsViewModel: EventDetailsViewModel
}
