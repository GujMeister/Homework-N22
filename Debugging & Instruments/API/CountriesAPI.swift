import Foundation

enum DataFetchError: Error {
    case networkError(Error)
    case decodingError(Error)
}

func getCountriesData(completion: @escaping (Result<[CountriesModelElement], DataFetchError>) -> Void) {
    guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
        completion(.failure(.networkError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(.networkError(error)))
            return
        }
        
        guard let data = data else {
            completion(.failure(.networkError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))))
            return
        }
        
        do {
            let countries = try JSONDecoder().decode(CountriesModel.self, from: data)
            completion(.success(countries))
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    task.resume()
}
