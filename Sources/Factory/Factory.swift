import Foundation

public protocol FactoryProtocol {
    func produce<ProduceType>(arguments: [Any]) -> ProduceType
}

public extension FactoryProtocol {
    func produce<ProduceType>() -> ProduceType {
        return produce(arguments: [])
    }
}
