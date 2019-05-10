//
//  TodoViewController.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import UIKit

protocol KanbanViewControllerDelegate: class {
    func didTapToPushTextEditor(title: String)
}

private let kReuseCellIdentifier = "kCellIdentifier"

class KanbanViewController: UIViewController {

    weak var delegate: KanbanViewControllerDelegate?

    private unowned let viewModel: KanbanViewModel

    private lazy var boardListView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: UIScreen.main.bounds.height - 200)
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .blue
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: kReuseCellIdentifier)
        return collectionView
    }()

    init(viewModel: KanbanViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Kanban"
        self.viewModel.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }

    private func viewSetup() {
        // Add Board Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddItem))

        // BoardList View
        view.addSubview(boardListView)
        boardListView.dataSource = self
        boardListView.translatesAutoresizingMaskIntoConstraints = false
        boardListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        boardListView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        boardListView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        boardListView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc func handleAddItem() {
        viewModel.state = .addBoard
        delegate?.didTapToPushTextEditor(title: "Create New Board")
    }
}

extension KanbanViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfBoards()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kReuseCellIdentifier, for: indexPath) as? BoardCollectionViewCell else {
            fatalError("Couldn't load BoaardCollectionViewCell")
        }
        if let board = viewModel.board(at: indexPath.row) {
            cell.setContentWith(board: board)
            cell.delegate = self
        }
        return cell
    }
}

extension KanbanViewController: BoardCollectionViewCellDelegate {
    func didSelectMoreAction(atBoard: Board) {
        viewModel.state = .addTask(into: atBoard)
        delegate?.didTapToPushTextEditor(title: "Create New Task")
    }
}


extension KanbanViewController: KanbanViewModelDelegate {
    func boardListDidUpdated() {
        boardListView.reloadData()
    }
}
