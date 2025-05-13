import Foundation
import KeychainAccess

public extension Keychain {
    static var localMixpanel: Keychain {
        return keychain(service: "LocalMixpanel", accessibility: .whenUnlockedThisDeviceOnly, synchronizable: false)
    }
    static var sharedMixpanel: Keychain {
        return whenUnlocked(service: "SharedMixpanel", synchronizable: true)
    }
    
    static func whenUnlocked(service: String, synchronizable: Bool) -> Keychain {
        return keychain(service: service, accessibility: .whenUnlocked, synchronizable: synchronizable)
    }
    
    static func keychain(service: String, accessibility: Accessibility, synchronizable: Bool) -> Keychain {
        return .init(service: service).accessibility(accessibility).synchronizable(synchronizable)
    }
}

extension Keychain: KeyedStorage {
    public func getData(forKey key: KeyedStorageKey) -> Data? {
        return try? getData(key.key)
    }
    
    public func addData(_ data: Data, forKey key: KeyedStorageKey) {
        try? set(data, key: key.key)
    }
    
    public func remove(key: KeyedStorageKey) {
        try? remove(key.key)
    }
    
    public func clean() {
        try? removeAll()
    }
}
