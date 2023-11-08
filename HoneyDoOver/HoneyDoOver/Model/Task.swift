//
//  HoneyDo.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation

class Task: Codable {
 
    var taskName: String
    let uuid: UUID
    var isDone: Bool
    var tasksToDo: [TaskToDo]
 
    init(taskName: String, uuid: UUID = UUID(), isDone: Bool = false, tasksToDo: [TaskToDo] = []) {
        self.taskName = taskName
        self.uuid = uuid
        self.isDone = isDone
        self.tasksToDo = tasksToDo
    }
}
// MARK: - Extension

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
