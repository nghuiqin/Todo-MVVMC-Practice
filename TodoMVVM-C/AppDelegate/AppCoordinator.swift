//
//  AppCoordinator.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import UIKit

class AppCoordinator: Coordinator<UITabBarController> {
    private let dependency = AppDependency()

    override func start() {
        let rootViewCoordinator = RootTabBarCoordinator(viewController: rootViewController)
        rootViewCoordinator.appDependency = dependency
        startChild(coordinator: rootViewCoordinator)
        super.start()
    }
}
