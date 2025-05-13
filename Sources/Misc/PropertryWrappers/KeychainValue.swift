import Foundation
import KeychainAccess

@propertyWrapper
public class KeychainValue<Value: Codable>: PersistentValue<Value> {
    public override var wrappedValue: Value {
        get { super.wrappedValue }
        set { super.wrappedValue = newValue }
    }
    public init(key: KeyedStorageKey, storage: Keychain) where Value: DefaultValueHolder {
        super.init(key: key, storage: storage)
    }
    
    public init(wrappedValue: Value, key: KeyedStorageKey, storage: Keychain) {
        super.init(wrappedValue: wrappedValue, key: key, storage: storage)
    }
}
