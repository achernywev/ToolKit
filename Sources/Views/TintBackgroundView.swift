import Foundation

public class TintBackgroundView: UILabel {
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        self.backgroundColor = tintColor
    }
}
