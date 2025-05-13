import Foundation

protocol DeepLinkCreator<DeepLink> {
    associatedtype DeepLink
    func createDeepLink(with params: [String: String]?) -> DeepLink?
}

enum DeepLinkParameterKey: String {
    case id
    case type
    case query
}
