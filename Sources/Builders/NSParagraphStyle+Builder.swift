import UIKit

public extension NSParagraphStyle {
    static func make(_ options: Option...) -> NSParagraphStyle { NSMutableParagraphStyle(options) }
    static func make(_ options: [Option]) -> NSParagraphStyle { NSMutableParagraphStyle(options) }
    
    public enum Option {
        case headIndent(CGFloat)
        case lineSpacing(CGFloat)
        case paragraphSpacing(CGFloat)
        case alignment(NSTextAlignment)
        case lineHeightMultiple(CGFloat)
        case lineBreakMode(NSLineBreakMode)
        
        
        public func apply(to style: NSMutableParagraphStyle) {
            switch self {
            case .headIndent(let indent): style.headIndent = indent
            case .lineSpacing(let spacing): style.lineSpacing = spacing
            case .paragraphSpacing(let spacing): style.paragraphSpacing = spacing
            case .alignment(let alignment): style.alignment = alignment
            case .lineHeightMultiple(let multiple): style.lineHeightMultiple = multiple
            case .lineBreakMode(let breakMode): style.lineBreakMode = breakMode
            }
        }
    }
}

public extension NSMutableParagraphStyle {
    public typealias Option = NSParagraphStyle.Option
    
    convenience init(_ options: Option...) { self.init(options) }
    
    convenience init(_ options: [Option]) {
        self.init()
        options.forEach { $0.apply(to: self) }
    }
    
    @discardableResult func apply(options: Option...) -> Self {
        options.forEach { $0.apply(to: self) }
        return self
    }
}
