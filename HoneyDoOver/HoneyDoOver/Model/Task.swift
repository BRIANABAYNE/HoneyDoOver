//
//  HoneyDo.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation
// Class need two things, properties and initalizers
class Task: Codable {
    // adopting codeable for JSON persit.
    
    var taskName: String // task
    let uuid: UUID // unique value - compaire to a task to make sure they are the same
    var isDone: Bool // for toggle
    var tasksToDo: [TaskToDo] // using for the Disclosure Indicator to display the number of items in the cell.
   
    // initizing the class Task, Assiging UUID,  idDone with their values, along with TaskToDo
    init(taskName: String, uuid: UUID = UUID(), isDone: Bool = false, tasksToDo: [TaskToDo] = []) {
        self.taskName = taskName
        self.uuid = uuid
        self.isDone = isDone
        self.tasksToDo = tasksToDo
    }
}
// MARK: - Extension
// I need equtable to delete - first index of only exsit with equtable, It is an extension becasue it requires more work.
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
