import UIKit
import Foundation

extension UIColor {
convenience init?(hex: String) {
    let r, g, b, a: CGFloat // записываюся переменные типа CGFloat
        
    if hex.hasPrefix("#") { // если начинается с # то мы читаем это
        let start = hex.index(hex.startIndex, offsetBy: 1) // считаваем пропуская первую
        let hexColor = String(hex[start...]) // создается подстрока hexColor без #
            
    if hexColor.count == 6 { //Проверяется, что длина шестнадцатеричной подстроки равна 6.
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
                
        if scanner.scanHexInt64(&hexNumber) { //
            r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
            g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
            b = CGFloat(hexNumber & 0x0000FF) / 255.0
            a = 1.0
                    
        self.init(red: r, green: g, blue: b, alpha: a)
        //инициализатор суперкласса UIColor.init(red:green:blue:alpha:) для создания объекта UIColor с заданными компонентами цвета.
        return
                }
            }
        }
        
        return nil
    }
    
}

