import Foundation

struct JsonCodableDataTask{
    
    enum fetchPlanetResualt{
        case success(JsonCodableModel)
        case failure(Error)
    }
    
    func fetchPlanet(comletion: @escaping(fetchPlanetResualt) ->Void){
        let urlPlanet = URL(string: "https://swapi.dev/api/planets/1")!
        var request = URLRequest(url: urlPlanet)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request){(data,responce, error) in
           //проверка соеденения с интернетом
            if let error = error{
                comletion(.failure(error))
                return
            }
            
            guard let data = data else {
                comletion(.failure(print("Нет данных") as! Error))
                return
            }
            
            do{
                // Декодирование JSON данных в модель
                let jsonModel = try JSONDecoder().decode(JsonCodableModel.self, from: data)
                comletion(.success(jsonModel))
            }
            catch{
                comletion(.failure(error))
            }
           
        }
        // Запуск задачи
        task.resume()
    }
    
    
    
}
