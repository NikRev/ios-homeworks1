import Foundation

enum APIError: Int {
    case success = 200
    case badRequest = 400
    case serverError = 500
    case unowned = 1000
}

struct JsonSerialization {
    
    enum FetchResult {
        case success(JsonModelSerialization)
        case failure(Error)
    }
    
    // Используйте completion handler для возврата результатов асинхронного запроса
    func fetch(completion: @escaping (FetchResult) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/6")!
        
        // Создаем запрос
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        // Создание задачи для выполнения запроса
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // Проверка на наличие ошибок
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoDataError", code: 0, userInfo: nil)))
                return
            }
            
            do {
                // Используем JSONSerialization
                if let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let userId = jsonDictionary["userId"] as? Int,
                        let id = jsonDictionary["id"] as? Int,
                        let title = jsonDictionary["title"] as? String?,
                        let completed = jsonDictionary["completed"] as? Bool {
                        
                        let jsonModel = JsonModelSerialization(userId: userId, id: id, title: title, completed: completed)
                        
                        // Возвращаем успешный результат
                        completion(.success(jsonModel))
                    } else {
                        // Возвращаем ошибку, если не удается извлечь значения
                        completion(.failure(NSError(domain: "DecodingError", code: 1, userInfo: nil)))
                    }
                }
            } catch {
                // Возвращаем ошибку декодирования JSON
                completion(.failure(error))
            }
        }
        
        // Запуск задачи
        task.resume()
    }
}


