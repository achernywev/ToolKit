import Foundation

extension UserDefaults: KeyedStorage {
    public func getData(forKey key: KeyedStorageKey) -> Data? {
        self.data(forKey: key.key)
    }
    
    public func addData(_ data: Data, forKey key: KeyedStorageKey) {
        self.set(data, forKey: key.key)
        self.synchronize()
    }
    
    public func remove(key: KeyedStorageKey) {
        self.removeObject(forKey: key.key)
        self.synchronize()
    }
    
    public func clean() {
        guard let bundleName = Bundle.main.bundleIdentifier else { return }
        self.removePersistentDomain(forName: bundleName)
        self.synchronize()
    }
}
