import Foundation

extension CGRect {
    public static var identity: Self { Self(x: 0, y: 0, width: 1.0, height: 1.0) }
    
    public var center: CGPoint {
        return .init(x: origin.x + size.width / 2,
                     y: origin.y + size.height / 2)
    }
}
