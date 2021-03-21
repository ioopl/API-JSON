import Foundation

struct Competition: Identifiable, Decodable {
    let id: Int
    let name: String
    
}

extension Competition {
    
    static var defaultCompetitions: [Competition] {
        return [
            Competition(id: 2021, name: "English Premier League"),
            Competition(id: 2014, name: "Spain La Liga"),
            Competition(id: 2019, name: "Italian Serie A"),
            Competition(id: 2002, name: "Germany Bundesliga"),
            Competition(id: 2003, name: "Netherlands Eredivise"),
            Competition(id: 2015, name: "France Ligue 1"),
            Competition(id: 2013, name: "Brazilian Série A"),
            Competition(id: 2017, name: "Portuguese Primera Liga")
        ]
    }
}
