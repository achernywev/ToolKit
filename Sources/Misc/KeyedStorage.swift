import Foundation

public enum KeyedStorageKey: RawRepresentable {
    case custom(key: String)
    
    public var key: String {
        rawValue
    }
    public var rawValue: String {
        switch self {
        case .custom(let key):
            return key
        }
    }
    public init(rawValue key: String) {
        self = .custom(key: key)
    }
}

public protocol KeyedStorage: AnyObject {
    func getData(forKey key: KeyedStorageKey) -> Data?
    func addData(_ data: Data, forKey key: KeyedStorageKey)
    func remove(key: KeyedStorageKey)
    func clean()
}

public extension KeyedStorage {
    subscript<T: Codable>(key: KeyedStorageKey) -> T? {
        get {
            return getObject(forKey: key)
        }
        set {
            addObject(newValue, forKey: key)
        }
    }
    
    func getObject<T: Decodable>(forKey key: KeyedStorageKey) -> T? {
        return T.init(jsonData: getData(forKey: key))
    }
    
    func addObject<T: Codable>(_ object: T, forKey key: KeyedStorageKey) {
        guard let data = object.jsonData else { return }
        addData(data, forKey: key)
    }
}
