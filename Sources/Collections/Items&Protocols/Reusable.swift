import UIKit

public protocol Reusable {
    var reuseIdentifier: String { get }
    var viewClass: UIView.Type { get }
}

public extension Reusable {
    var reuseIdentifier: String { viewClass.className }
}
