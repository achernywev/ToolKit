import UIKit

final class DeepLinkService<DeepLink>: NSObject, AppService {
    private let preparers: [any DeepLinkPreparer<DeepLink>]
    private let rootDeepLinkHandler: any DeepLinkHandler<DeepLink>
    
    init(rootDeepLinkHandler: any DeepLinkHandler<DeepLink>, preparers: [any DeepLinkPreparer<DeepLink>] = []) {
        self.preparers = preparers
        self.rootDeepLinkHandler = rootDeepLinkHandler
    }
    
    func open(url: URL) -> Bool {
        return open(some: url)
    }
    
    private func open(deepLink: DeepLink) {
        rootDeepLinkHandler.open(deeplink: deepLink, animated: true)
    }
    
    private func open(some value: Any) -> Bool {
        for preparer in preparers {
            guard let result = preparer.prepareDeepLink(from: value) else { continue }
            guard let deepLink = result.creator.createDeepLink(with: result.params) else { continue }
            open(deepLink: deepLink)
            return true
        }
        return false
    }
    
    // MARK: AppService methods
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return open(url: url)
    }
}
