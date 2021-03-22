import Foundation

protocol MatchListViewModelDelegate: AnyObject {
    func callbackWhenDataAvailable(matches: [Match])
}

class MatchListViewModel {
    
    var matches: [Match] = []
    var error: Error?
    var isLoading: Bool = false
    weak var delegate: MatchListViewModelDelegate?
    
    var service: WebService = DataWebService.shared
    
        func asyncFetchUpcomingMatches(competitionId: Int) {
            error = nil
            isLoading = true
    
            service.fetchUpcomingMatches(competitionId: competitionId) { (result) in
                //guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isLoading = false
    
                    switch result {
                    case .success(let matches):
                        self.matches = matches
                        self.delegate?.callbackWhenDataAvailable(matches: matches)
    
                    case .failure(let error):
                        self.error = error
                    }
                }
            }
        }
    
    func asyncFetchLatestMatches(competitionId: Int) {
        error = nil
        isLoading = true
        
        service.fetchLatestMatches(competitionId: competitionId) { (result) in
                self.isLoading = false
                
                switch result {
                case .success(let matches):
                    self.matches = matches
                    self.delegate?.callbackWhenDataAvailable(matches: matches)
                    
                case .failure(let error):
                    self.error = error
                }
        }
    }
}
