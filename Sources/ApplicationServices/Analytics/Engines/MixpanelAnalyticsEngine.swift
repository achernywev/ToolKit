import Foundation
import Mixpanel

public final class MixpanelAnalyticsEngine: NSObject {
    private var mixpanel: MixpanelInstance
    
    public init(token: String) {
        self.mixpanel = Mixpanel.initialize(token: token, trackAutomaticEvents: true, optOutTrackingByDefault: false,
                                            useUniqueDistinctId: true)
        super.init()
    }
    
    // MARK: - AppService protocol
    public func applicationWillResignActive(_ application: UIApplication) {
        let appSessionSuperProperties = ["date": Date()].mixpanel
        mixpanel.registerSuperProperties(appSessionSuperProperties)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10), execute: {
            for (key, _) in appSessionSuperProperties {
                self.mixpanel.unregisterSuperProperty(key)
            }
        })
    }
}

// MARK: - AnalyticsEngine protocol
extension MixpanelAnalyticsEngine: AnalyticsEngine {
    public func trackEvent(_ event: String, parameters: [String: Any]?) {
        let parametersLog = parameters.map { dict in
            "; parameters: [\n" + dict.reduce(into: "", { $0.append(contentsOf: "\t\($1.key): \($1.value)\n")}) + "]"
        } ?? ""
        print("💾 Event: \(event)\(parametersLog)")
        mixpanel.track(event: event, properties: parameters?.mixpanel)
        #if DEBUG
        mixpanel.flush()
        #endif
    }
    
    public func updateUserId(_ userId: String) {
        guard mixpanel.distinctId != userId else { return }
        
        mixpanel.createAlias(userId, distinctId: mixpanel.distinctId, andIdentify: false)        
        mixpanel.identify(distinctId: userId)
    }
    
    public func applySuperproperties(_ properties: AnalyticsEventProtocol.Properties) {
        mixpanel.registerSuperProperties(properties.mixpanel)
    }
}

private extension AnalyticsEventProtocol.Properties {
    var mixpanel: [String: MixpanelType] {
        return compactMapValues {
            guard let result = $0 as? MixpanelType else {
                print("NOT MIXPANEL TYPE: \($0)")
                if let result = tryToFix($0) {
                    print("\($0) WAS fixed")
                    return result
                } else {
                    print("\($0) NOT fixed")
                    return nil
                }
            }
            return result
        }
    }
    
    private func tryToFix(_ anyValue: Any) -> MixpanelType? {
        if let dictionary = anyValue as? Dictionary<String, Any> {
            return dictionary.mixpanel
        } else if let array = anyValue as? Array<Any> {
            return array.compactMap { tryToFix($0) }
        } else {
            return nil
        }
    }
}
