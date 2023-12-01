import Foundation

enum AppConfiguration: Int {
    case people = 0
    case starships = 1
    case planets = 2

    var baseURL: String {
        switch self {
        case .people:
            return "https://swapi.dev/api/people/8"
        case .starships:
            return "https://swapi.dev/api/starships/3"
        case .planets:
            return "https://swapi.dev/api/planets/5"
        }
    }
}

struct NetworkService {
    static func request(for configuration: AppConfiguration, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: configuration.baseURL) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный URL"])))
            return
        }

        let request = URLRequest(url: url)
        let session = URLSession.shared

        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка сети: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                print("Response Headers: \(httpResponse.allHeaderFields)")

                switch httpResponse.statusCode {
                case 200:
                    guard let data = data else {
                        print("Ошибка: Отсутствуют данные")
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Отсутствуют данные"])))
                        return
                    }
                    if let dataString = String(data: data, encoding: .utf8) {
                        print("Response Data: \(dataString)")
                    }
                    completion(.success(data))
                case 522:
                    print("Ошибка: Connection Timed Out")
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Connection Timed Out"])))
                case 404:
                    print("Ошибка: Соединение потеряно")
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Соединение потеряно"])))
                default:
                    print("Неизвестная ошибка")
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неизвестная ошибка"])))
                }
            }
        }

        dataTask.resume()
    }
}
