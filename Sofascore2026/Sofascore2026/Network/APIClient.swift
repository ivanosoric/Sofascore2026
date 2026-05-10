import Foundation

final class APIClient {
    
    private let baseURL = "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"
    
    func getEvents(
        sportSlug: String,
        completion: @escaping (Result<[APIEvent], Error>) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)/events?sport=\(sportSlug)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data else {
                return
            }
            
            do {
                let events = try JSONDecoder().decode([APIEvent].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(events))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

