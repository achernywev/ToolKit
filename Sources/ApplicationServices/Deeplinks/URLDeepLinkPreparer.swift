import Foundation

struct URLDeepLinkPreparer<DeepLink>: DeepLinkPreparer {
    private let deepLinkURLScheme: String
    private let creators: [String: any DeepLinkCreator<DeepLink>]
    init(deepLinkURLScheme: String, creators: [String: any DeepLinkCreator<DeepLink>]) {
        self.deepLinkURLScheme = deepLinkURLScheme
        self.creators = creators
    }
    
    func prepareDeepLink(from: Any) -> DeepLinkPreparationResult<DeepLink>? {
        guard let url = from as? URL else { return nil }
        guard url.scheme == deepLinkURLScheme else { return nil }
        guard let host = url.host, host.isEmpty == false else { return nil }
        guard let creator = creators[host] else { return nil }
        
        var params: [String: String]?
        if let query = url.query {
            params = [:]
            let components = query.components(separatedBy: "&")
            for component in components {
                let keyValue = component.components(separatedBy: "=")
                guard keyValue.count == 2 else { continue }
                params?[keyValue[0]] = keyValue[1]
            }
        }
        return DeepLinkPreparationResult(creator: creator, params: params)
    }
}
