import Foundation

struct JsonCodableModel: Codable {
    let name: String?
    let rotationPeriod: String?
    let orbitalPeriod: Int?  // Может быть Int?
    let diameter: String?
    let climate: String?
    let gravity: String?
    let terrain: String?
    let surfaceWater: String?  // Может быть String?
    let population: String?
    let residents, films: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod
        case orbitalPeriod
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents, films, created, edited, url
    }
    
}
