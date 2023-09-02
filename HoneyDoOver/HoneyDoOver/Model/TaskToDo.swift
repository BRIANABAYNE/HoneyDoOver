//
//  HoneyToDo.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation

class TaskToDo: Codable {
    // reading and writing - Need codeable for persistance 
    let taskToDoName: String // task to do
    let uuid: UUID // unique # - can compaire two taks with UUID to assure they are the same task. 
    var isFinished: Bool // for toggle
    var taskToDos: [Task]
    
    // init the class - assiging the value of UUID and isFinished.
    init(taskToDoName: String, isFinished: Bool = false, uuid: UUID = UUID(), taskToDos:[Task] = []) {
        self.taskToDoName = taskToDoName
        self.uuid = uuid
        self.isFinished = isFinished
        self.taskToDos = taskToDos
    }
}
// MARK: - Extenstion
// Need Equtable for delete - first index of.
extension TaskToDo: Equatable {
    static func == (lhs: TaskToDo, rhs: TaskToDo) -> Bool {
        // Creating a method for our code to bo able to compair two HoneyToDo - Look at lhs to rhs and if they are the same, it's the same task.
        return lhs.uuid == rhs.uuid
    }
}

