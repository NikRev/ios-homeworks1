import UIKit
import Foundation

class CustomButton:UIButton{
  
    var customBackgroundColor:UIColor?
    var tapAction: (() -> Void)?
    
    init(customBackgroundColor: UIColor?, title: String?, titleColor: UIColor?, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.customBackgroundColor = backgroundColor
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = cornerRadius // Устанавливаем cornerRadius из параметра
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Метод, вызываемый при нажатии кнопки
    @objc private func buttonTapped(){
        // Вызываем замыкание tapAction,
        tapAction?()
    }
}
