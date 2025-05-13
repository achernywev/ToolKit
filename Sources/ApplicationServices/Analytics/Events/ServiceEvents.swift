import Foundation

public enum ServiceEvent: AnalyticsEventProtocol {
    case optInTracking
    case optOutTracking
    case install(type: InstallType)
    
    public var customParameters: Properties? {
        guard case .install(let type) = self else {
            return nil
        }
        switch type {
        case .new:
            return ["install_type": "new"]
        case .reinstall(let sameDevice):
            return [
                "install_type": "reinstall",
                "same_device": sameDevice
            ]
        }
    }
}
