import Foundation

public protocol Updatable: AnyObject {
    var updateHandler: (() -> Void)? { get set }
}

public extension Updatable {
    func update() {
        updateHandler?()
    }
}
