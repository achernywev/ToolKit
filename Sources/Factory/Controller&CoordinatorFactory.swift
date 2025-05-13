import UIKit

//Helper struct to incapsulate all producing logic inside
public struct Producer {
    private let factory: FactoryProtocol
    fileprivate func produce<ProduceType>(arguments: [Any] = []) -> ProduceType {
        return factory.produce(arguments: arguments)
    }
    
    public init(factory: FactoryProtocol) {
        self.factory = factory
    }
}

public protocol ProducerHolderProtocol {
    var producer: Producer {get}
}

public protocol CoordinatorFactoryProtocol: ProducerHolderProtocol, CoordinatorProtocol {
    
}
 
public extension CoordinatorFactoryProtocol {
    func produceOnly<ProduceType: CoordinatorProtocol>() -> ProduceType {
        let coordinator: ProduceType = producer.produce()
        return coordinator
    }
    
    func produceWindowRoot<ProduceType: NavigationCoordinator>() -> ProduceType {
        let coordinator: ProduceType = producer.produce()
        UIApplication.shared.delegate?.window??.rootViewController = coordinator.navController
        return coordinator
    }
    
    func produceWindowRoot<ProduceType: TabBarCoordinator>() -> ProduceType {
        let coordinator: ProduceType = producer.produce()
        UIApplication.shared.delegate?.window??.rootViewController = coordinator.tabBarController
        return coordinator
    }
    
    func produceWindowRoot<ProduceType: TabBarCoordinator>(coordinators: [NavigationCoordinator]) -> ProduceType {
        let coordinator: ProduceType = produceWindowRoot()
        coordinator.setup(for: coordinators)
        return coordinator
    }
    
    func produceTabBar<ProduceType: NavigationCoordinator>(title: String? = nil, image: UIImage? = nil,
                                                           selectedImage: UIImage? = nil) -> ProduceType {
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        let coordinator: ProduceType = producer.produce()
        coordinator.navController.tabBarItem = tabBarItem
        return coordinator
    }
}

private var CoordinatorAssociatedKey = "CoordinatorAssociatedKey"
public protocol ControllerFactoryProtocol: ProducerHolderProtocol, CoordinatorProtocol {
    
}
 
public extension ControllerFactoryProtocol {
    typealias ControllerProduceType = UIViewController
    
    private func produce<ProducedType: ControllerProduceType>(arguments: [Any],
        then:((ProducedType) -> Void)? = nil, configure: ((ProducedType) -> Void)? = nil
    ) -> ProducedType {
        let controller: ProducedType = producer.produce(arguments: arguments)
        then?(controller)
        configure?(controller)
        if let baseController = controller as? ViewController {
            baseController.presenter.coordinator = self
        }
        else {
            objc_setAssociatedObject(controller, &CoordinatorAssociatedKey, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return controller
    }
    
//    func produceOnly<ProducedType: ControllerProduceType>() -> ProducedType {
//        return produceOnly(arguments: [])
//    }
    func produceOnly<ProducedType: ControllerProduceType>(arguments: Any..., then: ((ProducedType) -> ())? = nil) -> ProducedType {
        let controller: ProducedType = self.produce(arguments: arguments, then: then, configure: nil)
        return controller
    }
    
    func produceNavigationWrapped<ProducedType: ControllerProduceType>(_ type: ProducedType.Type, arguments: Any...,
                                                                       then: ((ProducedType) -> ())? = nil) -> UINavigationController {
        let vc = self.produce(arguments: arguments, then: then, configure: nil)
        let navigation: UINavigationController = producer.produce(arguments: [])
        navigation.viewControllers = [vc]
        return navigation
    }
    
//    func produceNavigationRoot<ProducedType: ControllerProduceType>(from: UINavigationController,
//                                                    animated: Bool = true, then: ((ProducedType) -> Void)? = nil) -> ProducedType {
//        return produceNavigationRoot(from: from, arguments: [], animated: animated, then: then)
//    }
    func produceNavigationRoot<ProducedType: ControllerProduceType>(from: UINavigationController, arguments: Any...,
                                                    animated: Bool = true, then: ((ProducedType) -> Void)? = nil) -> ProducedType {
        return self.produce(arguments: arguments, then: then,
                            configure: { (controller: ProducedType) in
            from.setViewControllers([controller], animated: animated)
        })
    }
    
//    func produceNavigationPush<ProducedType: ControllerProduceType>(from: UINavigationController,
//                                                    animated: Bool = true, then: ((ProducedType) -> Void)? = nil) -> ProducedType {
//        return produceNavigationPush(from: from, arguments: [], animated: animated, then: then)
//    }
    func produceNavigationPush<ProducedType: ControllerProduceType>(from: UINavigationController, arguments: Any...,
                                                    animated: Bool = true, then: ((ProducedType) -> Void)? = nil) -> ProducedType {
        return self.produce(arguments: arguments, then: then,
                            configure: { (controller: ProducedType) in
                                from.pushViewController(controller, animated: animated)
                            }
        )
    }
    
//    func produceWindowRoot<ProducedType: ControllerProduceType>(then: ((ProducedType) -> ())? = nil) -> ProducedType {
//        produceWindowRoot(arguments: [], then: then)
//    }
    func produceWindowRoot<ProducedType: ControllerProduceType>(arguments: Any...,
                                                                then: ((ProducedType) -> Void)? = nil) -> ProducedType {
        return self.produce(arguments: arguments, then: then,
                            configure: { (controller: ProducedType) in
            UIApplication.shared.delegate?.window??.rootViewController = controller;
        })
    }
    func produceWindowRootNavigationWrapped<ProducedType: ControllerProduceType>(_ type: ProducedType.Type, arguments: Any...,
                                                                then: ((ProducedType) -> Void)? = nil) -> UINavigationController {
        let vc: ProducedType = self.produce(arguments: arguments, then: then, configure: nil)
        return produce(arguments: [vc], configure: {
            UIApplication.shared.delegate?.window??.rootViewController = $0
        })
    }
    
//
//    func producePresent<ProducedType: ControllerProduceType>(from: UIViewController? = nil,
//                                                             navigationWrapped: Bool = false,
//                                                             animated: Bool = true,
//                                                             presentationStyle:  UIModalPresentationStyle = .fullScreen,
//                                                             transitionStyle:  UIModalTransitionStyle = .coverVertical,
//                                                             transitioningDelegate: UIViewControllerTransitioningDelegate? = nil,
//                                                             then: ((ProducedType) -> ())? = nil) -> ProducedType {
//        return producePresent(from: from, arguments: [], navigationWrapped: navigationWrapped, animated: animated, presentationStyle: presentationStyle, transitionStyle: transitionStyle, transitioningDelegate: transitioningDelegate, then: then)
//    }
    func producePresent<ProducedType: ControllerProduceType>(from: UIViewController? = nil, arguments: Any...,
                                                             navigationWrapped: Bool = false,
                                                             animated: Bool = true,
                                                             presentationStyle:  UIModalPresentationStyle = .fullScreen,
                                                             transitionStyle:  UIModalTransitionStyle = .coverVertical,
                                                             transitioningDelegate: UIViewControllerTransitioningDelegate? = nil,
                                                             then: ((ProducedType) -> ())? = nil) -> ProducedType {
        return self.produce(arguments: arguments, then: then, configure: { (controller: ProducedType) in
            let presentedController: UIViewController = {
                guard navigationWrapped else { return controller }
                let navigation: UINavigationController = producer.produce(arguments: [])
                navigation.viewControllers = [controller]
                return navigation
            }()
            presentedController.modalPresentationStyle = presentationStyle
            presentedController.transitioningDelegate = transitioningDelegate
            presentedController.modalTransitionStyle = transitionStyle
            
            let presenter: UIViewController = from?.topViewController() ?? UIApplication.shared.topViewController()
            presenter.present(presentedController, animated: animated, completion: nil)
        })
    }
}
