import Foundation

public enum InstallType: Codable {
    case new
    case reinstall(sameDevice: Bool)
}

extension KeyedStorageKey {
    static var localUserId: Self { .custom(key: "Mixpanel.LocalUserId") }
    static var globallUserId: Self { .custom(key: "Mixpanel.GloballUserId") }
    static var localDeviceId: Self { .custom(key: "Mixpanel.LocalDeviceId") }
    static var didTrackAttribution: Self { .custom(key: "Mixpanel.DidTrackAttribution") }
}

public struct UserAttributionTracker {
    @UserDefaultValue(key: .localDeviceId) private var localDeviceId: String?
    @UserDefaultValue(key: .didTrackAttribution) private var didTrackAttribution: Bool
    @KeychainValue(key: .localUserId, storage: .localMixpanel) private var localUserId: String?
    @KeychainValue(key: .globallUserId, storage: .sharedMixpanel) private var globallUserId: String?
    
    func attributinData() -> (installType: InstallType, userId: String)? {
        guard didTrackAttribution == false else {
            return nil
        }
        didTrackAttribution = true        
        
        let userIdToUse: String
        let installType: InstallType
        
        if let globallUserId = globallUserId {
            if localUserId == nil {
                installType = .reinstall(sameDevice: false)
            } else {
                installType = .reinstall(sameDevice: true)
            }
            
            userIdToUse = globallUserId
            localDeviceId = globallUserId
        } else {
            if let userId = localUserId {
                userIdToUse = userId
                installType = .reinstall(sameDevice: true)
            } else  {
                userIdToUse = UUID().uuidString
                
                installType = .new
                localUserId = userIdToUse
            }
            globallUserId = userIdToUse
        }
        
        return (installType, userIdToUse)
    }
    
    func updateUserId(_ userId: String) {
        localUserId = userId
        globallUserId = userId
    }
}
