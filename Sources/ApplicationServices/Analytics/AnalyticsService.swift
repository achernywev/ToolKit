import UIKit

public protocol AnalyticsUser {
    var userID: String { get }
    var properties: AnalyticsEventProtocol.Properties? { get }
}

public protocol AnalyticsProtocol {
    func updateUserId(_ userId: String)
    
    func trackEvent(_ event: String, parameters: [String: Any]?)
    func applySuperproperties(_ properties: AnalyticsEventProtocol.Properties)
}

public extension AnalyticsProtocol {
    func trackEvent(_ event: String) {
        trackEvent(event, parameters: nil)
    }
    
    func trackEvent(_ event: AnalyticsEventProtocol) {
        trackEvent(event.trackingName, parameters: event.parameters)
    }
}

public final class AnalyticsService: AppServicesResponder {
    public override var services: [AppService] {
        analyticsEngines
    }
    
    private let optionalEngines: [AnalyticsEngine]
    private let requiredEngines: [AnalyticsEngine]
    private let attManager: AppTrackingTransparencyProtocol?
    private let attributionTracker = UserAttributionTracker()
    
    private var analyticsEngines: [AnalyticsEngine] {
        if let attManager, attManager.isTrackingEnabled == false {
            return requiredEngines
        } else {
            return requiredEngines + optionalEngines
        }
    }
    
    public init(attManager: AppTrackingTransparencyProtocol? = nil,
         requiredEngines: [AnalyticsEngine], optionalEngines: [AnalyticsEngine] = []) {
        self.attManager = attManager
        self.requiredEngines = requiredEngines
        self.optionalEngines = optionalEngines
    }
    
    private func startService(options: [UIApplication.LaunchOptionsKey: Any]?) {
        attManager?.requestTrackingAuthorization(completion: { [weak self] in
            if self?.attManager?.isTrackingEnabled == true {
                self?.trackEvent(ServiceEvent.optInTracking)
                self?.optionalEngines.forEach { $0.launch(with: options) }
            } else {
                self?.trackEvent(ServiceEvent.optOutTracking)
                self?.optionalEngines.forEach { $0.terminate() }
            }
        })
    }
    
    // MARK: - AppService methods
    public override func application(_ application: UIApplication,
                              didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        if let attributionData = attributionTracker.attributinData() {
            trackEvent(ServiceEvent.install(type: attributionData.installType))
            updateUserId(attributionData.userId, includeAttributionTracker: false)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { [weak self] in
            self?.startService(options: launchOptions)
        })
        return result
    }
}

// MARK: - AnalyticsProtocol
extension AnalyticsService: AnalyticsProtocol {
    public func trackEvent(_ event: String, parameters: [String: Any]?) {
        analyticsEngines.forEach {
            $0.trackEvent(event, parameters: parameters)
        }
    }
    
    public func updateUserId(_ userId: String) {
        updateUserId(userId, includeAttributionTracker: true)
    }
    
    private func updateUserId(_ userId: String, includeAttributionTracker: Bool) {
        if includeAttributionTracker {
            attributionTracker.updateUserId(userId)
        }
        analyticsEngines.forEach {
            $0.updateUserId(userId)
        }
    }
    
    public func applySuperproperties(_ properties: AnalyticsEventProtocol.Properties) {
        analyticsEngines.forEach {
            $0.applySuperproperties(properties)
        }
    }
}
