import Foundation
import SnapKit

public extension ConstraintViewDSL {
    public enum Priority {
        //250
        case low
        //500
        case medium
        //750
        case high
        //1000
        case highest

        case custom(_ value: Float)

        fileprivate var value: Float {
            switch self {
            case .low: return 250
            case .medium: return 500
            case .high: return 750
            case .highest: return 1000
            case .custom(let value):
                return value
            }
        }
    }

    func setHorizontalHuggingPriority(_ priority: Priority) {
        contentHuggingHorizontalPriority = priority.value
    }
    func setVerticalHuggingPriority(_ priority: Priority) {
        contentHuggingVerticalPriority = priority.value
    }
    
    func setHorizontalCompressionResistance(_ priority: Priority) {
        contentCompressionResistanceHorizontalPriority = priority.value
    }
    func setVerticalCompressionResistance(_ priority: Priority) {
        contentCompressionResistanceVerticalPriority = priority.value
    }
}
