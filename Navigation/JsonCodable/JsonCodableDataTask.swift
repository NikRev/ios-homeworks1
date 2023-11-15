import Foundation

struct JsonCodableDataTask {
    
    enum FetchPlanetResult {
        case success(JsonCodableModel)
        case failure(Error)
    }
    
    func fetchPlanet(completion: @escaping (FetchPlanetResult) -> Void) {
        let urlPlanet = URL(string: "https://swapi.dev/api/planets/1")!
        var request = URLRequest(url: urlPlanet)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Проверка соединения с интернетом
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Проверка HTTP-статуса
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                let error = NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "NoDataError", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                // Декодирование JSON данных в модель
                let jsonModel = try JSONDecoder().decode(JsonCodableModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonModel))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        // Запуск задачи
        task.resume()
    }
}
