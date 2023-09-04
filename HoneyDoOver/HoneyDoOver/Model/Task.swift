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
    let uuid: UUID // unique value - compaire to task to make sure they are the same
    var isDone: Bool // for toggle
    // initizing the class Task, Assiging UUID and idDone with their values.
    init(taskName: String, uuid: UUID = UUID(), isDone: Bool = false) {
        self.taskName = taskName
        self.uuid = uuid
        self.isDone = isDone
    }
}
// MARK: - Extension
// I need equtable to delete - first index of only exsit with equtable, It is an extension becasue it requires more work.
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
