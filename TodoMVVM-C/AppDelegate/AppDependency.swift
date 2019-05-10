//
//  AppDependency.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import Foundation

struct AppDependency {
    let dataManager = TodoManager()
}

protocol CoordinatorDependency: class {
    var appDependency: AppDependency? {set get}
}
