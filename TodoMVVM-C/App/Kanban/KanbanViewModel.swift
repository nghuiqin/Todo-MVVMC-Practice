//
//  KanbanViewModel.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import Foundation

protocol KanbanViewModelDelegate: class {
    func boardListDidUpdated()
}

class KanbanViewModel {

    enum actionState {
        case addBoard
        case addTask(into: Board)
        case none
    }

    weak var delegate: KanbanViewModelDelegate?
    var state: actionState = .none

    private var boardList: [Board]
    private let todoManager: TodoManager

    init(manager: TodoManager) {
        todoManager = manager
        boardList = todoManager.fetchBoards()
    }

    func numberOfBoards() -> Int {
        return boardList.count
    }

    func board(at index: Int) -> Board? {
        if index > numberOfBoards() || numberOfBoards() == 0 {
            return nil
        }
        return boardList[index]
    }

    func takeActionWith(text: String) {
        switch state {
        case .addBoard:
            let newBoard = todoManager.createBoard(name: text)
            boardList.append(newBoard)
            state = .none

        case .addTask(let board):
            todoManager.createTask(name: text, into: board)
            state = .none

        default:
            break
        }
        delegate?.boardListDidUpdated()
    }
}
