import UIKit

public extension UIView {
    var isVisible: Bool {
        get { !isHidden }
        set { isHidden = !newValue }
    }
    
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    func addLayoutGuides(_ guides: UILayoutGuide...) {
        guides.forEach { addLayoutGuide($0) }
    }
    
    func addLayoutGuides(_ guides: [UILayoutGuide]) {
        guides.forEach { addLayoutGuide($0) }
    }
    
    func roundCorners(radius: CGFloat, mask: CACornerMask = .all, clipsToBounds: Bool = true) {
        layer.cornerRadius = radius
        layer.maskedCorners = mask
        self.clipsToBounds = clipsToBounds
    }
    
    
    func bringToFront() {
        superview?.bringSubviewToFront(self)
    }
    
    func frame(of view: UIView) -> CGRect {
        return convert(view.frame, from: view.superview)
    }
    
    func safeLayoutIfNeeded() {
        guard window != nil else { return }
        layoutIfNeeded()
    }
    
    func removeAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func shake(duration: TimeInterval = 0.07, length: Float = 10, repeatCount: Float = 2, completion: (() -> Void)? = nil) {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.autoreverses = true
        animation.repeatCount = repeatCount
        animation.fromValue = -length
        animation.toValue = length
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
    
    func setupConstraints(inContainer container: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -insets.bottom),
            trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -insets.right)
        ])
    }
}
