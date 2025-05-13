import AppTrackingTransparency

public protocol AppTrackingTransparencyProtocol {
    var isTrackingEnabled: Bool { get }
    func requestTrackingAuthorization(completion: @escaping () -> Void)
}

public final class AppTrackingTransparencyManager: AppTrackingTransparencyProtocol {
    public var isTrackingEnabled: Bool {
        guard #available(iOS 14, *) else { return true }
        return status == .authorized
    }
    
    @available(iOS 14, *)
    private var status: ATTrackingManager.AuthorizationStatus {
        ATTrackingManager.trackingAuthorizationStatus
    }
    
    public func requestTrackingAuthorization(completion: @escaping () -> Void) {
        guard #available(iOS 14, *) else { return }
        guard status == .notDetermined else { return }
        ATTrackingManager.requestTrackingAuthorization { _ in
            completion()
        }
    }
}
