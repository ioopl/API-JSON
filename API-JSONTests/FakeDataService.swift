import Foundation
@testable import API_JSON

class FakeDataService: WebService {
    // Have to put it here as the Date() timestamp was failing tests
    let expectedMatch: Match = {
        let homeTeam = Team(id: 1, name: "", area: nil, shortName: "", tla: "", clubColors: "", crestUrl: "", address: "", phone: "", website: "", email: nil, founded: nil, venue: nil, squad: nil)
        let awayTeam = Team(id: 2, name: "", area: nil, shortName: "", tla: "", clubColors: "", crestUrl: "", address: "", phone: "", website: "", email: nil, founded: nil, venue: nil, squad: nil)
        let match = Match(id: 1, utcDate: Date(), status: "", matchday: 1, stage: "", group: "", homeTeam: homeTeam , awayTeam: awayTeam, score: MatchScore())
        return match
    }()
    
    func startEndDateFilter(isUpcoming: Bool) -> (String, String) {
        return ("" , "")
    }
    
    func fetchLatestMatches(competitionId: Int, completion: @escaping (dataResponseHandler) -> ()) {
        
        return completion(.success([expectedMatch]))
    }
    
    func fetchUpcomingMatches(competitionId: Int, completion: @escaping (Result<[Match], Error>) -> ()) {
        //completion(Result<[Match], Error>)
        let homeTeam = Team(id: 1, name: "", area: nil, shortName: "", tla: "", clubColors: "", crestUrl: "", address: "", phone: "", website: "", email: nil, founded: nil, venue: nil, squad: nil)
        let awayTeam = Team(id: 2, name: "", area: nil, shortName: "", tla: "", clubColors: "", crestUrl: "", address: "", phone: "", website: "", email: nil, founded: nil, venue: nil, squad: nil)
        let match = Match(id: 1, utcDate: Date(), status: "", matchday: 1, stage: "", group: "", homeTeam: homeTeam , awayTeam: awayTeam, score: MatchScore())
        completion(.success([match]))
    }
}
