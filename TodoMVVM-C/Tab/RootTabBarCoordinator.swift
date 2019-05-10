//
//  RootTabBarCoordinator.swift
//  TodoMVVM-C
//
//  Created by Hui Qin Ng on 2019/5/10.
//

import UIKit

class RootTabBarCoordinator: Coordinator<UITabBarController>, CoordinatorDependency {

    var appDependency: AppDependency?
    private let tabBarDelegateProxy = TabBarDelegateProxy()
    private let navigationDelegateProxy = NavigationDelegateProxy()
    private (set) var selectedCoordinator: Coordinating?
    private (set) var kanbanCoordinator: KanbanCoordinator!
    private (set) var todoCoordinator: TodoCoordinator!

    override func start() {
        constructChildCoordinatorsIfNeed()
        selectedCoordinator?.start()
        super.start()
    }

    private func constructChildCoordinatorsIfNeed() {
        if started {
            return
        }

        let kanbanNavigationController = generatedNavigationController(tabBar: .favorites)
        kanbanCoordinator = KanbanCoordinator(viewController: kanbanNavigationController)

        let todoNavigationController = generatedNavigationController(tabBar: .mostRecent)
        todoCoordinator = TodoCoordinator(viewController: todoNavigationController)

        rootViewController.delegate = tabBarDelegateProxy
        tabBarDelegateProxy.delegate = self

        childCoordinators = [kanbanCoordinator, todoCoordinator]

        childCoordinators.forEach { coordinating in
            if let coordinatingDependency = coordinating as? CoordinatorDependency {
                coordinatingDependency.appDependency = appDependency
            }
        }

        rootViewController.viewControllers = [kanbanNavigationController, todoNavigationController]
        selectedCoordinator = kanbanCoordinator
    }

    private final func generatedNavigationController(tabBar systemItem: UITabBarItem.SystemItem) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: systemItem, tag: Int(arc4random()%10))
        navigationController.interactivePopGestureRecognizer?.delegate = navigationDelegateProxy
        navigationController.delegate = navigationDelegateProxy
        return navigationController
    }
}

extension RootTabBarCoordinator: TabBarDelegateProxyDelegate {
    func tabBarDelegateProxy(_ proxy: TabBarDelegateProxy, didSelect viewController: UIViewController) {
        selectedCoordinator?.deactive()
        let newSelectedCoordinator = childCoordinators[rootViewController.selectedIndex]
        newSelectedCoordinator.start()
        newSelectedCoordinator.active()
        selectedCoordinator = newSelectedCoordinator
    }
}

protocol TabBarDelegateProxyDelegate: class {
    func tabBarDelegateProxy(_ proxy: TabBarDelegateProxy, didSelect viewController: UIViewController) -> Void
}

class TabBarDelegateProxy: NSObject, UITabBarControllerDelegate {

    weak var delegate: TabBarDelegateProxyDelegate?

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        delegate?.tabBarDelegateProxy(self, didSelect: viewController)
    }
}
