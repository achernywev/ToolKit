import UIKit

public extension UIDevice {
    static var isPad: Bool {
        return current.userInterfaceIdiom == .pad
    }
    static var isPhone: Bool {
        return current.userInterfaceIdiom == .phone
    }
}
