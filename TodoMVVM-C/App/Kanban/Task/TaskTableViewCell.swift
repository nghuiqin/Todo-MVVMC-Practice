//
//  TaskTableViewCell.swift
//  TodoMVVM-C
//
//  Created by Hui Qin Ng on 2019/5/10.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
