import Foundation

struct Publications {
    var author: String
    var description: String
    var image: String
    var views: Int
    var likes: Int
}

extension Publications {
    static func make() -> [Publications] {
        [
            Publications(author: "Ревин Никита",
                          description: "Авто-Тюнинг",
                          image: "profile_image",
                          views: 33,
                          likes: 21),
            Publications(author: "Екатерина Еникеева",
                          description: "Питания для похудения",
                          image: "healthyFood",
                          views: 33,
                          likes: 100),
            Publications(author: "Игорь Нагибатор",
                          description: "Как выиграть в Counter-Strike",
                          image: "conterStieke 1",
                          views: 33,
                          likes: 33),
            Publications(author: "Никита Зварыкин",
                          description: "Освоим программирование за час",
                          image: "programOnHour",
                          views: 33,
                          likes: 33),
            Publications(author: "Никита Зварыкин",
                          description: "Освоим программирование за час",
                          image: "programOnHour",
                          views: 33,
                          likes: 33),
            Publications(author: "Никита Зварыкин",
                          description: "Освоим программирование за час",
                          image: "programOnHour",
                          views: 33,
                          likes: 33),
            Publications(author: "Никита Зварыкин",
                          description: "Освоим программирование за час",
                          image: "programOnHour",
                          views: 33,
                          likes: 33),
            Publications(author: "Ревин Никита",
                          description: "Авто-Тюнинг",
                          image: "profile_image",
                          views: 33,
                          likes: 21)
        ]
    }
}
