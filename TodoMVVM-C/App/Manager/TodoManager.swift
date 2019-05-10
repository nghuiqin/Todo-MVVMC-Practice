//
//  TodoManager.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import Foundation
import CoreData

struct TodoManager {

    private let container = NSPersistentContainer(name: "TodoMVVM-C")

    init() {
        container.loadPersistentStores { persistentStoreDescription, error in
            guard error == nil else {
                fatalError("Failed to load NSPersistenContainer")
            }
        }
    }

    func fetchBoards() -> [Board] {
        let fetchRequest = NSFetchRequest<Board>(entityName: "Board")
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print("Failed to fetch board list with \(error.localizedDescription)")
            return []
        }
    }

    func createBoard(name: String) -> Board {
        let board = Board(context: container.viewContext)
        board.name = name
        saveContext()
        return board
    }

    func createTask(name: String, into board: Board) {
        let task = Task(context: container.viewContext)
        task.name = name
        board.addToTasks(task)
        saveContext()
    }

    private func saveContext() {
        do {
            try container.viewContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
