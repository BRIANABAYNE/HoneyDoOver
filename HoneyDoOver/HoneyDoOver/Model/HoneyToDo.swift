//
//  HoneyToDo.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation

class HoneyToDo: Codable {
    // reading and writing - Need codeable for persistance 
    let honeyToDo: String
    let uuid: UUID
    var isFinished: Bool // for toggle 
    
    init(honeyToDo: String, isFinished: Bool = false, uuid: UUID = UUID() ) {
        self.honeyToDo = honeyToDo
        self.uuid = uuid
        self.isFinished = isFinished
    }
}

// MARK: - Extenstion

extension HoneyToDo: Equatable {
    static func == (lhs: HoneyToDo, rhs: HoneyToDo) -> Bool {
        // Creating a method for our code to bo able to compair two HoneyToDo - Look at lhs to rhs and if they are the same, it's the same task.
        return lhs.uuid == rhs.uuid
    }
}

