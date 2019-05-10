//
//  TextEditorCoordinator.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import UIKit

protocol TextEditorCoordinatorDelegate: class {
    func textDidChanged(text: String)
}

class TextEditorCoordinator: Coordinator<UINavigationController> {

    var editingText: String = ""
    var name: String = ""

    weak var delegate: TextEditorCoordinatorDelegate?

    fileprivate (set) var viewModel: TextEditorViewModel!

    override func start() {
        if !started {
            viewModel = TextEditorViewModel(string: editingText)
            let viewController = TextEditorViewController(viewModel: viewModel)
            viewController.delegate = self
            viewController.title = name
            show(viewController: viewController)
        }
        super.start()
        printCoordinatorHierarchy()
    }
}

extension TextEditorCoordinator: TextEditorViewControllerDelegate {
    func textDidSave() {
        delegate?.textDidChanged(text: viewModel.contentString)
        rootViewController.popViewController(animated: true)
    }
}
