import UIKit
import Foundation
import StorageService


public struct Publicantions {
var author: String
var  description: String
var image: String
var views: Int
var likes: Int
}

extension Publicantions{
    static func make() -> [Publicantions]{
        [
            Publicantions(author: "Ревин Никита",
                          description: "Авто-Тюнинг",
                          image: "profile_image",
                          views: 33,
                          likes: 21),
            Publicantions(author: "Екатерина Еникеева",
                          description: "Питания для похуденияrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrv",
                          image: "healthyFood",
                          views: 33,
                          likes: 100),
            Publicantions(author: "Игорь Нагибатор",
                          description: "Как выиграть в conterStrikerfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrv",
                          image: "conterStieke",
                          views: 33,
                          likes: 33),
            Publicantions(author: "Никита Зварыкин",
                          description: "Освоим программирование за часrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvrfrfrfrfrfrfrvrvrvrvrvv",
                          image: "programOnHour",
                          views: 33,
                          likes: 33)
            
        
        ]
    }
}
