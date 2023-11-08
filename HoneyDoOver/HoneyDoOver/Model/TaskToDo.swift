//
//  HoneyToDo.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation

class TaskToDo: Codable {
   
    let taskToDoName: String
    let uuid: UUID
    var isFinished: Bool
    var taskToDos: [Task]
    
  
    init(taskToDoName: String, isFinished: Bool = false, uuid: UUID = UUID(), taskToDos:[Task] = []) {
        self.taskToDoName = taskToDoName
        self.uuid = uuid
        self.isFinished = isFinished
        self.taskToDos = taskToDos
    }
}
// MARK: - Extenstion

extension TaskToDo: Equatable {
    static func == (lhs: TaskToDo, rhs: TaskToDo) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

