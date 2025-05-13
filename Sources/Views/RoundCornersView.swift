import Foundation

open class RoundCornersView: UIView {
    open override func customInitialization() {
        super.customInitialization()
        self.clipsToBounds = true
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
