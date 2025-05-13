import Foundation

public extension UIBarButtonItem {
    convenience init(systemItem: UIBarButtonItem.SystemItem, actionHandler: @escaping () -> Void) {
        self.init(systemItem: systemItem, primaryAction: .init(handler: { _ in actionHandler() }))
    }
    
    convenience init(title: String? = nil, image: UIImage? = nil, actionHandler: @escaping () -> Void) {
        self.init(title: title, image: image, primaryAction: .init(handler: { _ in actionHandler() }))
    }
}
