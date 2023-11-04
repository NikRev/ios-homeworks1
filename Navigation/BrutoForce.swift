import Foundation

class BruteForce {
    func bruteForce(in text: String) -> (letters: [Character], numbers: [Int]) {
        var foundLetters: [Character] = []
        var foundNumbers: [Int] = []
        
        for char in text {
            if char.isLetter {
                foundLetters.append(char)
            } else if char.isNumber {
                if let number = Int(String(char)) {
                    foundNumbers.append(number)
                }
            }
        }
        
        return (letters: foundLetters, numbers: foundNumbers)
    }
}

// Пример использования класса BruteForce
let text = "Hello, 12345 World!"
let solver = BruteForce()
let result = solver.bruteForce(in: text)

//print("Найденные буквы: \(result.letters)")
//print("Найденные числа: \(result.numbers)")
