import Foundation

public extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        let className = String(describing: self)
        let components = className.components(separatedBy: ".")
        
        return components.last!
    }
}
