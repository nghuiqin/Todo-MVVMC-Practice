//
//  KanbanCoordinator.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import UIKit

class KanbanCoordinator: Coordinator<UINavigationController>, CoordinatorDependency {
    var appDependency: AppDependency?
    private (set) var viewController: KanbanViewController!
    private (set) var viewModel: KanbanViewModel!

    override func start() {
        if let manager = appDependency?.dataManager, !started {
            viewModel = KanbanViewModel(manager: manager)
            viewController = KanbanViewController(viewModel: viewModel)
            viewController.delegate = self
            show(viewController: viewController)
        } else {
            return
        }
        super.start()
        printCoordinatorHierarchy()
    }
}

extension KanbanCoordinator: KanbanViewControllerDelegate {

    func didTapToPushTextEditor(title: String) {
        let editorCoordinator = TextEditorCoordinator(viewController: rootViewController)
        editorCoordinator.delegate = self
        editorCoordinator.name = title
        startChild(coordinator: editorCoordinator)
    }
}

extension KanbanCoordinator: TextEditorCoordinatorDelegate {

    func textDidChanged(text: String) {
        viewModel.takeActionWith(text: text)
    }
}
