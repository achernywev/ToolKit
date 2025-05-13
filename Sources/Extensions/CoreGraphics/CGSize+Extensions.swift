import Foundation
import CoreGraphics

public extension CGSize {
    static func square(_ size: CGFloat) -> Self {
        return Self(width: size, height: size)
    }
    static func wh(_ width: CGFloat, _ height: CGFloat) -> Self {
        return Self(width: width, height: height)
    }
    
    func isApproximatelyEqual(to size: CGSize?, threshold: CGFloat = 1.0) -> Bool {
        guard let size else { return false }
        return abs(width - size.width) < threshold && abs(height - size.height) < threshold
    }
    
    func isApproximatelyDifferent(from size: CGSize?, threshold: CGFloat = 1.0) -> Bool {
        isApproximatelyEqual(to: size, threshold: threshold) == false
    }
}

extension CGSize: @retroactive Hashable { }
