import UIKit

public extension UIImage {
    static func image(color: UIColor, size: CGSize? = nil, cornerRadius: CGFloat = 0) -> UIImage? {
        let side = max(3 * cornerRadius, 10)
        let imageSize = size ?? CGSize(width: side, height: side)
        
        let scale = UIScreen.main.scale
        let format = UIGraphicsImageRendererFormat.preferred()
        format.scale = scale
        format.opaque = false
        
        let renderer = UIGraphicsImageRenderer(size: imageSize, format: format)
        let existImage = renderer.image { _ in
            let rect = CGRect(origin: .zero, size: imageSize)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            path.addClip()
            
            color.setFill()
            path.fill()
        }
        
        let inset = max(cornerRadius, 5)
        return (size != nil) ? existImage : existImage.resizableImage(withCapInsets: .all(inset), resizingMode: .tile)
    }
    
    func resizePreservingAspect(to maxSize: CGSize, fit: Bool = true) -> UIImage {
        let aspectWidth = maxSize.width / size.width
        let aspectHeight = maxSize.height / size.height
        
        let aspectRatio = fit ? min(aspectWidth, aspectHeight) : max(aspectWidth, aspectHeight)
        let newSize = CGSize(width: size.width * aspectRatio, height: size.height * aspectRatio)
        
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = self.scale
        format.opaque = false
        
        let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
