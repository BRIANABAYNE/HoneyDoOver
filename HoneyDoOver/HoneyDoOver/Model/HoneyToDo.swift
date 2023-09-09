//
//  HoneyToDo.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation

class HoneyToDo: Codable {
    
    let honeyToDo: String
    let uuid: UUID
    var isFinished: Bool
    
    init(honeyToDo: String, isFinished: Bool = false, uuid: UUID = UUID() ) {
        self.honeyToDo = honeyToDo
        self.uuid = uuid
        self.isFinished = isFinished
    }
}

// MARK: - Extenstion
extension HoneyToDo: Equatable {
    static func == (lhs: HoneyToDo, rhs: HoneyToDo) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

