//
//  BoardCollectionViewCell.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import UIKit

protocol BoardCollectionViewCellDelegate: class {
    func didSelectMoreAction(atBoard: Board)
}

private let kReuseCellIdentifier = "kCellIdentifier";

class BoardCollectionViewCell: UICollectionViewCell {

    weak var delegate: BoardCollectionViewCellDelegate?

    private (set) var boardNameLabel: UILabel!
    private (set) var taskListView: UITableView!
    private (set) var boardViewModel: BoardViewModel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func viewSetup() {
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true

        let moreButton = UIButton(type: .custom)
        moreButton.tintColor = .white
        moreButton.setTitle("...", for: .normal)
        contentView.addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        moreButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 30)
        moreButton.addTarget(self, action: #selector(handleMoreAction), for: .touchUpInside)

        boardNameLabel = UILabel(frame: CGRect.zero)
        boardNameLabel.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(boardNameLabel)
        boardNameLabel.translatesAutoresizingMaskIntoConstraints = false
        boardNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        boardNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true

        taskListView = UITableView(frame: CGRect.zero)
        taskListView.estimatedRowHeight = 50
        backgroundColor = .clear
        taskListView.register(TaskTableViewCell.self, forCellReuseIdentifier: kReuseCellIdentifier)
        contentView.addSubview(taskListView)
        taskListView.translatesAutoresizingMaskIntoConstraints = false
        taskListView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        taskListView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        taskListView.topAnchor.constraint(equalTo: boardNameLabel.bottomAnchor, constant: 10).isActive = true
        taskListView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        taskListView.dataSource = self
    }

    func setContentWith(board: Board) {
        boardViewModel = BoardViewModel(board: board)
        boardNameLabel.text = boardViewModel.name
        taskListView.reloadData()
    }

    @objc private func handleMoreAction() {
        delegate?.didSelectMoreAction(atBoard: boardViewModel.board)
    }
}

extension BoardCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardViewModel.numberOfTasks()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kReuseCellIdentifier, for: indexPath) as? TaskTableViewCell else {
            fatalError("TaskTableViewCell is not registerd")
        }

        if let task = boardViewModel.task(at: indexPath.row) {
            cell.textLabel?.text = task.name
        }
        return cell
    }
}
