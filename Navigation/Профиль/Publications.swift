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
            Publications(author: NSLocalizedString("author_revin", comment: ""),
                          description: NSLocalizedString("auto_tuning", comment: ""),
                          image: "profile_image",
                          views: 33,
                          likes: 21),
            Publications(author: NSLocalizedString("author_ekaterina",comment: ""),
                          description: NSLocalizedString("healthy_food", comment: ""),
                          image: "healthyFood",
                          views: 33,
                          likes: 100),
            Publications(author: NSLocalizedString("author_igor",comment: ""),
                          description: NSLocalizedString("counter_strike", comment: ""),
                          image: "conterStieke",
                          views: 33,
                          likes: 33),
            Publications(author: NSLocalizedString("author_nikita", comment: ""),
                          description: NSLocalizedString("programming_hour", comment: ""),
                          image: "programmingOnHour",
                          views: 33,
                          likes: 33),
            Publications(author: NSLocalizedString("author_nikita", comment: ""),
                          description: NSLocalizedString("programming_hour", comment: ""),
                          image: "programOnHour",
                          views: 33,
                          likes: 33),
            Publications(author: NSLocalizedString("author_nikita", comment: ""),
                          description: NSLocalizedString("programming_hour", comment: ""),
                          image: "programOnHour",
                          views: 33,
                          likes: 33),
            Publications(author: NSLocalizedString("author_nikita", comment: ""),
                          description: NSLocalizedString("programming_hour", comment: ""),
                          image: "programOnHour",
                          views: 33,
                          likes: 33),
            Publications(author: NSLocalizedString("author_revin", comment: ""),
                          description: NSLocalizedString("auto_tuning", comment: ""),
                          image: "profile_image",
                          views: 33,
                          likes: 21)
        ]
    }
}
