import Foundation

struct JsonModelSerialization: Codable {
    let userId, id: Int
    let title: String?
    let completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id, title, completed
    }
}
