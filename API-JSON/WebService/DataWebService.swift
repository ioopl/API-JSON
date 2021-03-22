import Foundation

public typealias dataResponseHandler = (Result<[Match], Error>)

public protocol WebService {
    func startEndDateFilter(isUpcoming: Bool) -> (String, String)
    
    func fetchLatestMatches(competitionId: Int, completion: @escaping(dataResponseHandler) -> ())
    func fetchUpcomingMatches(competitionId: Int, completion: @escaping(Result<[Match], Error>) -> ())
}

struct DataWebService: WebService {
    
    static let shared = DataWebService()
    private let urlSession = URLSession.shared
    private let apiKey = "08ccc29e7aba4ff2840a3da31e6e7425"
    private let baseURL = "https://api.football-data.org/v2/"
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private init() {}

    /// The API has a limitation. It cannot fetch Data beyond 10 days. So to get 30 days of history, we will need to make 3 API calls of 10 days each, and then merge the results to show a history of 10 days. 
    internal func startEndDateFilter(isUpcoming: Bool) -> (String, String) {
        let today = Date()
        // Seconds: 86400 = 1440 = 24 hours (todays date +/- 10 days) as API only allows only 10 days of data in a call. 
        let tenDays = today.addingTimeInterval(86400 * (isUpcoming ? 10 : -10))
        
        let todayText = DataWebService.dateFormatter.string(from: today)
        let tenDaysText = DataWebService.dateFormatter.string(from: tenDays)
        return isUpcoming ? (todayText, tenDaysText) : (tenDaysText, todayText)
    }
    
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // Asynchronous Execution: Executing the closure asynchronously on dispatch queue, the queue will hold the closure in memory to be used in future. Currently we have no idea when the closure will get executed.
    // Asynchronously starting a task will directly return on the calling thread without blocking
    //@escaping - This has to be escaping closure as it takes time over network

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
