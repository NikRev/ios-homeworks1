import XCTest

class LogInViewControllerTests: XCTestCase {

    // Тест на успешный вход
    func testSuccessfulLogin() {
        let viewController = LogInViewController()
        viewController.loadViewIfNeeded()

        // Заполните поля логина и пароля действительными учетными данными
        viewController.loginTextField.text = "validUsername"
        viewController.passwordTextField.text = "validPassword"

        // Вызов метода входа
        viewController.buttonLogFunc()

        // Убедитесь, что пользователь перенаправлен на ProfileViewController
        XCTAssertTrue(viewController.navigationController?.topViewController is ProfileViewController)
    }

    // Тест на регистрацию
    func testUserRegistration() {
        let viewController = LogInViewController()
        viewController.loadViewIfNeeded()

        // Заполните поля логина и пароля уникальными учетными данными
        viewController.loginTextField.text = "newUser"
        viewController.passwordTextField.text = "newPassword"

        // Вызов метода регистрации
        viewController.buttonRegisterFunc()

        // Убедитесь, что пользователь успешно зарегистрирован и перенаправлен на ProfileViewController
        XCTAssertTrue(viewController.navigationController?.topViewController is ProfileViewController)
    }

    // Тест на обработку ошибок при неверных учетных данных
    func testErrorHandlingForInvalidCredentials() {
        let viewController = LogInViewController()
        viewController.loadViewIfNeeded()

        // Заполните поля логина и пароля неверными учетными данными
        viewController.loginTextField.text = "invalidUsername"
        viewController.passwordTextField.text = "invalidPassword"

        // Вызов метода входа
        viewController.buttonLogFunc()

        // Убедитесь, что появляется предупреждающее окно с сообщением об ошибке
        XCTAssertTrue(viewController.presentedViewController is UIAlertController)
    }
}
