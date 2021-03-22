import Foundation
import UIKit

struct Utilities {
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func loadStub<D: Decodable>(url: URL) -> D {
        let data = try! Data(contentsOf: url)
        do {
            let d = try jsonDecoder.decode(D.self, from: data)
            return d
        } catch {
            print(error.localizedDescription)
            fatalError()
        }
    }
}

extension UITableView {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .medium)
            self.backgroundView = activityView
            activityView.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.backgroundView = nil
        }
    }
}
