import Foundation

public extension CACornerMask {
    static var topLeft: Self { layerMinXMinYCorner }
    static var topRight: Self { layerMaxXMinYCorner }
    static var bottomLeft: Self { layerMinXMaxYCorner }
    static var bottomRight: Self { layerMaxXMaxYCorner }
    
    static var top: Self { [topLeft, topRight] }
    static var bottom: Self { [bottomLeft, bottomRight] }
    static var left: Self { [topLeft, bottomLeft] }
    static var right: Self { [topRight, bottomRight] }
    
    static var all: Self { [topLeft, topRight, bottomLeft, bottomRight] }
}
