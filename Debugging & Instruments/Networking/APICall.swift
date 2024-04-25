import Foundation

enum DataFetchError: Error {
    case networkError(Error)
    case decodingError(Error)
}

func getCountriesData(completion: @escaping (Result<[CountriesModelElement], DataFetchError>) -> Void) {
    let urlString = NetworkConstants.shared.serverAddress
    
    guard let url = URL(string: urlString) else {
        completion(.failure(.networkError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Network error: \(error.localizedDescription)")
            completion(.failure(.networkError(error)))
            return
        }

        guard let data = data else {
            print("No data received")
            completion(.failure(.networkError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))))
            return
        }

        do {
            let countries = try JSONDecoder().decode(CountriesModel.self, from: data)
            completion(.success(countries))
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            completion(.failure(.decodingError(error)))
        }
    }

    task.resume()
}


