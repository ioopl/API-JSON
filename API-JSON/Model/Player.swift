import Foundation

struct Player: Identifiable, Decodable, Equatable {
    
    var id: Int?
    var name: String
    var firstName: String?
    var dateOfBirth: String?
    var countryOfBirth: String?
    var nationality: String?
    var position: String?
    var shirtNumber: Int?
    var role: String?
}
