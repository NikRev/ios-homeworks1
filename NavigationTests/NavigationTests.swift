import XCTest


class FeedModelTests: XCTestCase {

    // Тест проверки, что результат проверки слова верен, когда слово совпадает с секретным словом
    func testWordCheckCorrectResult() {
        // Arrange (Подготовка данных)
        let secretWord = "OpenAI" // Устанавливаем секретное слово
        let feedModel = FeedModel(secretWord: secretWord) // Создаем экземпляр FeedModel с установленным секретным словом

        // Act (Действие)
        feedModel.check(word: "OpenAI") // Вызываем метод check с корректным словом

        // Assert (Проверка результата)
        let expectation = XCTestExpectation(description: "WordCheckResult notification") // Создаем ожидание для уведомления
        let observer = NotificationCenter.default.addObserver(forName: .wordCheckResult, object: nil, queue: nil) { notification in
            // Обработка уведомления
            guard let userInfo = notification.userInfo,
                  let isCorrect = userInfo["isCorrect"] as? Bool else {
                XCTFail("Notification does not contain the expected userInfo") // Если уведомление не содержит ожидаемую информацию, то тест считается проваленным
                return
            }

            XCTAssertTrue(isCorrect, "Word check result should be correct") // Проверяем, что результат проверки слова действительно верен
            expectation.fulfill() // Уведомляем о завершении ожидания
        }

        wait(for: [expectation], timeout: 1.0) // Ожидаем завершение ожидания события (уведомления) в течение 1 секунды
        NotificationCenter.default.removeObserver(observer) // Удаляем наблюдателя после завершения теста
    }

    // Тест проверки, что результат проверки слова неверен, когда слово не совпадает с секретным словом
    func testWordCheckIncorrectResult() {
        // Arrange
        let secretWord = "OpenAI"
        let feedModel = FeedModel(secretWord: secretWord)

        // Act
        feedModel.check(word: "InvalidWord") // Вызываем метод check с некорректным словом

        // Assert
        let expectation = XCTestExpectation(description: "WordCheckResult notification")
        let observer = NotificationCenter.default.addObserver(forName: .wordCheckResult, object: nil, queue: nil) { notification in
            guard let userInfo = notification.userInfo,
                  let isCorrect = userInfo["isCorrect"] as? Bool else {
                XCTFail("Notification does not contain the expected userInfo")
                return
            }

            XCTAssertFalse(isCorrect, "Word check result should be incorrect") // Проверяем, что результат проверки слова действительно неверен
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
        NotificationCenter.default.removeObserver(observer)
    }
}
