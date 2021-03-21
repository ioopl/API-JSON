import Foundation


struct FootballDataService {
    
    static let shared = FootballDataService()
    private let urlSession = URLSession.shared
    private let apiKey = "08ccc29e7aba4ff2840a3da31e6e7425"
    private let baseURL = "https://api.football-data.org/v2/"
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private init() {}

    private func startEndDateFilter(isUpcoming: Bool) -> (String, String) {
        let today = Date()
        let tenDays = today.addingTimeInterval(86400 * (isUpcoming ? 10 : -10))
        
        let todayText = FootballDataService.dateFormatter.string(from: today)
        let tenDaysText = FootballDataService.dateFormatter.string(from: tenDays)
        return isUpcoming ? (todayText, tenDaysText) : (tenDaysText, todayText)
    }
    
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    //@escaping - has to be escaping as its taking time
    // Asynchronous Execution: When you are executing the closure asynchronously on dispatch queue, the queue will hold the closure in memory for you, to be used in future. In this case you have no idea when the closure will get executed.
    // Notes: Asynchronously starting a task will directly return on the calling thread without blocking
    func fetchLatestMatches(competitionId: Int, completion: @escaping(Result<[Match], Error>) -> ()) {
        let (tenDaysAgoText, todayText) = startEndDateFilter(isUpcoming: false)
        
        let url = baseURL + "/matches?status=FINISHED&competitions=\(competitionId)&dateFrom=\(tenDaysAgoText)&dateTo=\(todayText)"
        let urlRequest = URLRequest(url: URL(string: url)!)
        fetchData(request: urlRequest) { (result: Result<MatchResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.matches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUpcomingMatches(competitionId: Int, completion: @escaping(Result<[Match], Error>) -> ()) {
        let (tenDaysAgoText, todayText) = startEndDateFilter(isUpcoming: true)
        
        let url = baseURL + "/matches?status=SCHEDULED&competitions=\(competitionId)&dateFrom=\(tenDaysAgoText)&dateTo=\(todayText)"
        let urlRequest = URLRequest(url: URL(string: url)!)

        fetchData(request: urlRequest) { (result: Result<MatchResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.matches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchData<D: Decodable>(request: URLRequest, completion: @escaping(Result<D, Error>) -> ()) {
        var urlRequest = request
        urlRequest.addValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data not found"])
                completion(.failure(error))
                return
            }
            
            do {
                let d = try self.jsonDecoder.decode(D.self, from: data)
                completion(.success(d))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


struct StandingResponse: Decodable {
    var standings: [Standing]?
}
