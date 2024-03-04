import XCTest

class FeedViewControllerTests: XCTestCase {

    // Тест для корректной обработки правильного ввода пароля
    func testCorrectPasswordInput() {
        // Arrange
        let viewController = FeedViewController()
        let notificationExpectation = expectation(forNotification: NSNotification.Name("WordCheckResult"), object: nil) { notification in
            guard let userInfo = notification.userInfo as? [String: Any],
                  let isCorrect = userInfo["isCorrect"] as? Bool else {
                return false
            }
            return isCorrect
        }

        // Act
        viewController.loadViewIfNeeded()
        viewController.textField.text = "ваш_секретный_пароль"
        viewController.checkGuess()

        // Assert
        wait(for: [notificationExpectation], timeout: 1.0)
        XCTAssertEqual(viewController.resultLabel.text, NSLocalizedString("Password correct", comment: ""))
        XCTAssertEqual(viewController.resultLabel.textColor, .green)
    }

    // Тест для корректной обработки неправильного ввода пароля
    func testIncorrectPasswordInput() {
        // Arrange
        let viewController = FeedViewController()
        let notificationExpectation = expectation(forNotification: NSNotification.Name("WordCheckResult"), object: nil) { notification in
            guard let userInfo = notification.userInfo as? [String: Any],
                  let isCorrect = userInfo["isCorrect"] as? Bool else {
                return false
            }
            return !isCorrect
        }

        // Act
        viewController.loadViewIfNeeded()
        viewController.textField.text = "неправильный_пароль"
        viewController.checkGuess()

        // Assert
        wait(for: [notificationExpectation], timeout: 1.0)
        XCTAssertEqual(viewController.resultLabel.text, NSLocalizedString("Password incorrect", comment: ""))
        XCTAssertEqual(viewController.resultLabel.textColor, .red)
    }

    // Тест для корректного обновления темы
    func testThemeUpdate() {
        // Arrange (Подготовка)
        let viewController = FeedViewController()

        // Act (Действие)
        viewController.loadViewIfNeeded()
        let initialBackgroundColor = viewController.view.backgroundColor
        let initialTextColor = viewController.textField.textColor

        // Изменяем стиль пользовательского интерфейса для имитации изменения темы
        if #available(iOS 13.0, *) {
            viewController.overrideUserInterfaceStyle = .dark
        }

        // Вызываем изменение параметров траитов для имитации смены темы
        viewController.traitCollectionDidChange(UITraitCollection(userInterfaceStyle: .dark))

        // Assert (Проверка)
        XCTAssertEqual(viewController.view.backgroundColor, .darkBackgroundFeed)
        XCTAssertEqual(viewController.textField.textColor, .lightTextFeed)

        // Возвращаем стиль пользовательского интерфейса к исходному значению
        if #available(iOS 13.0, *) {
            viewController.overrideUserInterfaceStyle = .unspecified
        }

        // Вызываем изменение параметров траитов для имитации смены темы
        viewController.traitCollectionDidChange(UITraitCollection(userInterfaceStyle: .light))

        // Убеждаемся, что тема восстановлена в исходное состояние
        XCTAssertEqual(viewController.view.backgroundColor, initialBackgroundColor)
        XCTAssertEqual(viewController.textField.textColor, initialTextColor)
        
    }

}
