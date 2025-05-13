import UIKit

public extension String {
    func attributed(_ attributes: Attribute...) -> NSAttributedString {
        attributed(with: attributes)
    }
    
    func attributed(with attributes: [Attribute] = []) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes.rawValues)
    }
    
    public enum Attribute {
        case font(UIFont)
        case foregroundColor(UIColor)
        case kern(CGFloat)
        case baselineOffset(CGFloat)
        case paragraphStyle(NSParagraphStyle)
        case link(URL)
        case strikethroughStyle(NSUnderlineStyle)
        case underlineStyle(NSUnderlineStyle)
        
        var key: NSAttributedString.Key {
            switch self {
            case .font: return .font
            case .foregroundColor: return .foregroundColor
            case .kern: return .kern
            case .baselineOffset: return .baselineOffset
            case .paragraphStyle: return .paragraphStyle
            case .link: return .link
            case .strikethroughStyle: return .strikethroughStyle
            case .underlineStyle: return .underlineStyle
            }
        }
        
        var value: Any {
            switch self {
            case .font(let font): return font
            case .foregroundColor(let color): return color
            case .kern(let kern): return kern
            case .baselineOffset(let offset): return offset
            case .paragraphStyle(let style): return style
            case .link(let url): return url.absoluteString
            case .strikethroughStyle(let style): return NSNumber(value: style.rawValue)
            case .underlineStyle(let style): return NSNumber(value: style.rawValue)
            }
        }
        
        public static func color(_ color: UIColor) -> Self { .foregroundColor(color) }
        
        public static func lineHeightMultiple(_ value: CGFloat) -> Self { .paragraphStyle(.lineHeightMultiple(value)) }
        public static func lineSpacing(_ value: CGFloat) -> Self { .paragraphStyle(.lineSpacing(value)) }
        public static func textAlignment(_ value: NSTextAlignment) -> Self { .paragraphStyle(.alignment(value)) }
        
        public static func paragraphStyle(_ options: NSParagraphStyle.Option...) -> Self { .paragraphStyle(.make(options)) }
    }
}

extension Array where Element == String.Attribute {
    var rawValues: [NSAttributedString.Key: Any] {
        var result = [NSAttributedString.Key: Any]()
        forEach { result[$0.key] = $0.value }
        return result
    }
}

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    static func make(_ attributes: String.Attribute...) -> Self {
        return attributes.rawValues
    }
}
