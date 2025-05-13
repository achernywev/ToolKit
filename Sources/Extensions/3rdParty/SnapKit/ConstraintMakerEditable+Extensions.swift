import Foundation

import Foundation
import SnapKit

public extension ConstraintMakerEditable {
    // This allows to use "inset(.top(22))" instead of "inset(UIEdgeInsets.top(22))"
    @discardableResult
    func inset(_ amount: UIEdgeInsets) -> ConstraintMakerEditable {
        return inset(amount as ConstraintInsetTarget)
    }
}
