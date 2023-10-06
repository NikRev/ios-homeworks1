import Foundation
import UIKit

extension Notification.Name {
    static let wordCheckResult = Notification.Name("WordCheckResult")
}

class FeedModel {
    let secretWord: String

    init(secretWord: String) {
        self.secretWord = secretWord
    }

    func check(word: String) {
        let isCorrect = word == secretWord
        let userInfo: [AnyHashable: Any] = ["isCorrect": isCorrect]
        NotificationCenter.default.post(name: .wordCheckResult, object: nil, userInfo: userInfo)
    }
}
