//
//  TodoCoordinator.swift
//  TodoMVVM-C
//
//  Created by Hui Qin Ng on 2019/5/10.
//

import UIKit

class TodoCoordinator: Coordinator<UINavigationController>, CoordinatorDependency {
    var appDependency: AppDependency?
    private (set) var viewController: UIViewController!

    override func start() {
        if started {
            return
        }
        let vc = TodoViewController()
        viewController = vc
        show(viewController: viewController)
        super.start()
    }
}
