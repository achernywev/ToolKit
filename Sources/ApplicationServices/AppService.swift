import UIKit

public protocol AppService: NSObject, UIApplicationDelegate & UNUserNotificationCenterDelegate {}

public enum AppServiceDefaults {
    // MARK: - Methods with default return value `true`
    public static let willFinishLaunchingWithOptions = true
    public static let didFinishLaunchingWithOptions = true

    // MARK: - Methods with default return value `false`
    public static let openUrlWithOptions = false
    public static let continueUserActivity = false
}

public extension AppService {
    @discardableResult
    func launch(with options: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let willFinishResult: Bool? = application?(UIApplication.shared, willFinishLaunchingWithOptions: options)
        let didFinishResult: Bool? = application?(UIApplication.shared, didFinishLaunchingWithOptions: options)

        return (willFinishResult ?? false) || (didFinishResult ?? false)
    }

    @discardableResult
    func terminate() -> Bool {
        applicationWillTerminate?(UIApplication.shared)
        return responds(to: #selector(applicationWillTerminate(_:)))
    }
}
