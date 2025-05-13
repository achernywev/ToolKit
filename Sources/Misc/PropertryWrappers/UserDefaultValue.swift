import Foundation

@propertyWrapper
public class UserDefaultValue<Value: Codable>: PersistentValue<Value> {
    public override var wrappedValue: Value {
        get { super.wrappedValue }
        set { super.wrappedValue = newValue }
    }
    
    public convenience init(key: String, storage: KeyedStorage = UserDefaults.standard) where Value: DefaultValueHolder {
        self.init(key: .custom(key: key), storage: storage)
    }
    
    public convenience init(wrappedValue: Value, key: String, storage: KeyedStorage = UserDefaults.standard) {
        self.init(wrappedValue: wrappedValue, key: .custom(key: key), storage: storage)
    }
    
    public override init(key: KeyedStorageKey, storage: KeyedStorage = UserDefaults.standard) where Value: DefaultValueHolder {
        super.init(key: key, storage: storage)
    }
    
    public override init(wrappedValue: Value, key: KeyedStorageKey, storage: KeyedStorage = UserDefaults.standard) {
        super.init(wrappedValue: wrappedValue, key: key, storage: storage)
    }
}
