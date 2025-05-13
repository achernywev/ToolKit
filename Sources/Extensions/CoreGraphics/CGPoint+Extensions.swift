import Foundation

extension CGPoint {
    public func distance(to other: CGPoint) -> CGFloat {
        let dx = pow((x - other.x), 2)
        let dy = pow((y - other.y), 2)
        
        return sqrt(dx + dy)
    }
}
