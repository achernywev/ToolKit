import Foundation

@propertyWrapper
open class PersistentValue<Value: Codable> {
    private let key: KeyedStorageKey
    private let defaultValue: Value
    private let storage: KeyedStorage
    
    open var wrappedValue: Value {
        get { storage[key] ?? defaultValue }
        set { storage[key] = newValue }
    }
    
    convenience public init(wrappedValue: Value, key: String, storage: KeyedStorage) {
        self.init(wrappedValue: wrappedValue, key: .custom(key: key), storage: storage)
    }
    convenience public init(key: String, storage: KeyedStorage) where Value: DefaultValueHolder {
        self.init(key: .custom(key: key), storage: storage)
    }
    
    public init(wrappedValue: Value, key: KeyedStorageKey, storage: KeyedStorage) {
        self.defaultValue = wrappedValue
        self.key = key
        self.storage = storage
    }
    public init(key: KeyedStorageKey, storage: KeyedStorage) where Value: DefaultValueHolder {
        self.defaultValue = Value.defaultValue
        self.key = key
        self.storage = storage
    }
}
