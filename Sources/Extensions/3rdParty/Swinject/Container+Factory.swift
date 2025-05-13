import UIKit
import Swinject

extension Container: FactoryProtocol {
    public func produce<ProduceType>(arguments: [Any]) -> ProduceType {
        let numberOfArguments = arguments.count
        switch numberOfArguments {
        case 1:
            return self.resolve(ProduceType.self, argument: arguments[0])!
        case 2:
            return self.resolve(ProduceType.self, arguments: arguments[0], arguments[1])!
        case 3:
            return self.resolve(ProduceType.self, arguments: arguments[0], arguments[1], arguments[2])!
        case 4:
            return self.resolve(ProduceType.self, arguments: arguments[0], arguments[1], arguments[2], arguments[3])!
        default:
            return self.resolve(ProduceType.self)!
        }
    }
}
