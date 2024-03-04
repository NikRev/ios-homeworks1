import UIKit
import Foundation

class PaddedTextField: UITextField {
    var textEdgeInsets: UIEdgeInsets = .zero {
        didSet { setNeedsDisplay() }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textEdgeInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textEdgeInsets)
    }
}
