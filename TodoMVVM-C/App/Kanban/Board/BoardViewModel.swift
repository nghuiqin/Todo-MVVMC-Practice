//
//  BoardViewModel.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import Foundation

protocol BoardViewModelOutput: class {
    var name: String? { get }
    func numberOfTasks() -> Int
    func task(at index: Int) -> Task?
}

class BoardViewModel: BoardViewModelOutput {
    let board: Board

    init(board: Board) {
        self.board = board
    }

    var name: String? {
        return board.name
    }

    func numberOfTasks() -> Int {
        if let tasks = board.tasks {
            return tasks.count
        }
        return 0
    }

    func task(at index: Int) -> Task? {
        guard let tasks = board.tasks?.array as? [Task] else { return nil }
        if index > numberOfTasks() || numberOfTasks() == 0 {
            return nil
        }
        return tasks[index]
    }
}
