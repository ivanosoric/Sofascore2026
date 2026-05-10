import Foundation

struct APIEvent: Decodable {
    let id: Int
    let homeTeam: APITeam
    let awayTeam: APITeam
    let startTimestamp: Int
    let status: String
    let league: APILeague?
    let homeScore: Int?
    let awayScore: Int?
}

struct APITeam: Decodable {
    let id: Int
    let name: String
    let logoUrl: String?
    let country: APICountry?
}

struct APILeague: Decodable {
    let id: Int
    let name: String
    let country: APICountry?
    let logoUrl: String?
}

struct APICountry: Decodable {
    let name: String
}
