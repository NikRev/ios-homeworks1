import Foundation

struct JsonCodablePeople{
    
    // Общий метод для выполнения запроса
    func fetchData1<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let urlPeople = URL(string: "https://swapi.dev/api/people/1/")!
        var request = URLRequest(url: urlPeople)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "YourApp", code: 123, userInfo: [NSLocalizedDescriptionKey: "No data available"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

    func fetchData2<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let urlPeople = URL(string: "https://swapi.dev/api/people/2/")!
        var request = URLRequest(url: urlPeople)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "YourApp", code: 123, userInfo: [NSLocalizedDescriptionKey: "No data available"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    func fetchData4<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let urlPeople = URL(string: "https://swapi.dev/api/people/4/")!
        var request = URLRequest(url: urlPeople)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "YourApp", code: 123, userInfo: [NSLocalizedDescriptionKey: "No data available"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
    func fetchData6<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let urlPeople = URL(string: "https://swapi.dev/api/people/6/")!
        var request = URLRequest(url: urlPeople)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "YourApp", code: 123, userInfo: [NSLocalizedDescriptionKey: "No data available"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    func fetchData7<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let urlPeople = URL(string: "https://swapi.dev/api/people/7/")!
        var request = URLRequest(url: urlPeople)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "YourApp", code: 123, userInfo: [NSLocalizedDescriptionKey: "No data available"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
    func fetchData8<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let urlPeople = URL(string: "https://swapi.dev/api/people/8/")!
        var request = URLRequest(url: urlPeople)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "YourApp", code: 123, userInfo: [NSLocalizedDescriptionKey: "No data available"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
    func fetchData9<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let urlPeople = URL(string: "https://swapi.dev/api/people/9/")!
        var request = URLRequest(url: urlPeople)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "YourApp", code: 123, userInfo: [NSLocalizedDescriptionKey: "No data available"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
    func fetchData11<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let urlPeople = URL(string: "https://swapi.dev/api/people/11/")!
        var request = URLRequest(url: urlPeople)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "YourApp", code: 123, userInfo: [NSLocalizedDescriptionKey: "No data available"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    func fetchData43<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let urlPeople = URL(string: "https://swapi.dev/api/people/43/")!
        var request = URLRequest(url: urlPeople)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "YourApp", code: 123, userInfo: [NSLocalizedDescriptionKey: "No data available"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
    func fetchData62<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let urlPeople = URL(string: "https://swapi.dev/api/people/62/")!
        var request = URLRequest(url: urlPeople)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "YourApp", code: 123, userInfo: [NSLocalizedDescriptionKey: "No data available"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
