import UIKit

public struct EmptyStateContent {
    public let icon: UIImage?
    public let title: String
    public let subTitle: String?
    public let buttonTitle: String?
    
    public init(icon: UIImage? = nil, title: String, subTitle: String? = nil, buttonTitle: String? = nil) {
        self.icon = icon
        self.title = title
        self.subTitle = subTitle
        self.buttonTitle = buttonTitle
    }
}
