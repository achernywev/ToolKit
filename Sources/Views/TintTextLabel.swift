import UIKit

public class TintTextLabel: UILabel {
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        self.textColor = tintColor
    }
}
