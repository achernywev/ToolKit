import Foundation

/// This is the object using in the app to descibe the particular place where we should redirect the user.
/// The logic to create the DeepLink object will be described in particular DeepLinkPreparer.
/// For instance the logic how to create the DeepLink from URL described in URLDeepLinkPreparer.
///
///
/// The main idea is pretty simple:
/// Creator is responsible for creation the particular DeepLink from its parameters. It checks do we have all the parameters needed in place.
/// Preparer is responsible for parsing some types of the object we might use to create the DeepLink from. Like urls, user activity, backend structs etc

enum DeepLinkHandling<DeepLink>: CustomStringConvertible {
    // deeplink successfully handled
    case opened(DeepLink)

    // deeplink was rejected because it can't be handeled, with optional log message
    case rejected(DeepLink, String?)

    // deeplink handling delayed because more data is needed
    case delayed(DeepLink, Bool)

    // deeplink was passed through to some other handler
    case passedThrough(to: any DeepLinkHandler<DeepLink>, DeepLink)
    
    var description: String {
        switch self {
        case .opened(let deeplink):
            return "Opened deeplink \(deeplink)"
        case .rejected(let deeplink, let reason):
            return "Rejected deeplink \(deeplink) for reason : \(reason ?? "unknown")"
        case .delayed(let deeplink, _):
            return "Delayed deeplink \(deeplink)"
        case .passedThrough(let handler, let deeplink):
            return "Passed through deeplink \(deeplink) to \(type(of: handler))"
        }
    }
}

protocol DeepLinkHandler<DeepLink>: AnyObject {
    associatedtype DeepLink
    
    // stores the current state of deeplink handling
    var deeplinkHandling: DeepLinkHandling<DeepLink>? { get set }
    
    // attempts to handle deeplink and returns next state
    func handle(deeplink: DeepLink, animated: Bool) -> DeepLinkHandling<DeepLink>
}

extension DeepLinkHandler {
    // Attempts to open deeplink and updates its state,
    // should be always called instead of method that returns state
    func open(deeplink: DeepLink, animated: Bool) {
        let result = handle(deeplink: deeplink, animated: animated)
        deeplinkHandling = result
        
        if case let .passedThrough(handler, deeplink) = result {
            handler.open(deeplink: deeplink, animated: animated)
        }
    }
    
    // Call to complete deeplink handling if it was delayed
    func completeDeeplinkHandling() {
        if case let .delayed(deeplink, animated) = deeplinkHandling {
            open(deeplink: deeplink, animated: animated)
        }
    }
}
