import UIKit

public protocol CoordinatorProtocol {
    
}

open class NavigationCoordinator: CoordinatorProtocol, ControllerFactoryProtocol {
    public let producer: Producer
    public let navController: UINavigationController
    
    public init(producer: Producer, navController: UINavigationController) {
        self.producer = producer
        self.navController = navController
    }
    
    public init<T: UIViewController>(producer: Producer, navController: UINavigationController, root: T.Type) {
        self.producer = producer
        self.navController = navController
        produceNavigationRoot(from: navController) as T
    }
}

open class TabBarCoordinator: CoordinatorProtocol, ControllerFactoryProtocol {
    public let producer: Producer
    public let tabBarController: UITabBarController
    
    public init(producer: Producer, tabBarController: UITabBarController) {
        self.producer = producer
        self.tabBarController = tabBarController
    }
    
    public func setup(for coordinators: [NavigationCoordinator]) {
        let viewControllers: [UIViewController] = coordinators.map { coordinator in
            return coordinator.navController
        }
        tabBarController.viewControllers = viewControllers

        let isHiddenAndTranslucent = viewControllers.count < 2
        tabBarController.tabBar.isHidden = isHiddenAndTranslucent
        tabBarController.tabBar.isTranslucent = isHiddenAndTranslucent
    }
}
