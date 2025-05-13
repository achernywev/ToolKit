import UIKit

open class AppServicesResponder: UIResponder, AppService {
    open var services: [AppService] { fatalError("Not implemented") }

    // MARK: - Methods with default return value `true`
    open func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return perform({
            $0.application?(application, willFinishLaunchingWithOptions: launchOptions)
        }, defaultValue: AppServiceDefaults.willFinishLaunchingWithOptions)
    }
    
    open func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return perform({
            $0.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }, defaultValue: AppServiceDefaults.didFinishLaunchingWithOptions)
    }

    // MARK: - Methods with default return value `false`
    open func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return perform({
            $0.application?(application, open: url, options: options)
        }, defaultValue: AppServiceDefaults.openUrlWithOptions)
    }
    
    open func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return perform({
            $0.application?(application, continue: userActivity, restorationHandler: restorationHandler)
        }, defaultValue: AppServiceDefaults.continueUserActivity)
    }
    
    // MARK: - void methods without return value
    open func applicationDidBecomeActive(_ application: UIApplication) {
        for service in services { service.applicationDidBecomeActive?(application) }
    }

    open func applicationWillResignActive(_ application: UIApplication) {
        for service in services { service.applicationWillResignActive?(application) }
    }

    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        for service in services { service.applicationDidReceiveMemoryWarning?(application) }
    }
    
    open func applicationDidEnterBackground(_ application: UIApplication) {
        for service in services { service.applicationDidEnterBackground?(application) }
    }

    open func applicationWillEnterForeground(_ application: UIApplication) {
        for service in services { service.applicationWillEnterForeground?(application) }
    }

    open func applicationWillTerminate(_ application: UIApplication) {
        for service in services { service.applicationWillTerminate?(application) }
    }

    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        for service in services { service.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }

    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        for service in services { service.application?(application, didFailToRegisterForRemoteNotificationsWithError: error) }
    }
    
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        for service in services {
            service.application?(application, didReceiveRemoteNotification: userInfo,
                                 fetchCompletionHandler: completionHandler)
        }
    }

    // MARK: - UNUserNotificationCenterDelegate
    open func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        for service in services {
            service.userNotificationCenter?(center, willPresent: notification,
                                            withCompletionHandler: completionHandler)
        }
    }
    
    open func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        for service in services { service.userNotificationCenter?(center, didReceive: response, withCompletionHandler: completionHandler) }
    }
    
    open func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        for service in services { service.userNotificationCenter?(center, openSettingsFor: notification) }
    }
    
    // MARK: - private methods
    private func perform(_ handler: (AppService) -> (Bool?), defaultValue: Bool) -> Bool {
        var result = defaultValue
        for service in services {
            guard let val = handler(service), result == defaultValue else { continue }
            result = val
        }
        return result
    }
}
