import Foundation

struct MatchResponse: Decodable {
    var matches: [Match]
}

public struct Match: Identifiable, Decodable {
    
    public var id: Int
    var utcDate: Date
    var status: String
    var matchday: Int
    var stage: String?
    var group: String?
    
    var homeTeam: Team
    var awayTeam: Team
    
    var score: MatchScore
}

struct MatchScore: Decodable {
    var winner: String?
    var duration: String?
    
    var fullTime: MatchScoreTime?
    var halfTime: MatchScoreTime?
    var extraTime: MatchScoreTime?
    var penalties: MatchScoreTime?
    
    var isHomeWinner: Bool {
        return (winner ?? "").lowercased().contains("home")
    }
    
    var isAwayWinner: Bool {
        return (winner ?? "").lowercased().contains("away")
    }
}

struct MatchScoreTime: Decodable {
    
    var homeTeam: Int?
    var awayTeam: Int?
}


