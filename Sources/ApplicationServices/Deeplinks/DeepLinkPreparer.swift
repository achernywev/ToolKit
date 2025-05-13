import UIKit

struct DeepLinkPreparationResult<DeepLink> {
    let creator: any DeepLinkCreator<DeepLink>
    let params: [String: String]?
}

protocol DeepLinkPreparer<DeepLink> {
    associatedtype DeepLink
    func prepareDeepLink(from: Any) -> DeepLinkPreparationResult<DeepLink>?
}
