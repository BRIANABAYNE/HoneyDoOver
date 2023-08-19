//
//  HoneyToDo.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation

struct HoneyToDo {
    
    let honeyToDo: String
    let uuid: UUID = UUID()
    let isFinished: Bool = false
    
}

// MARK: - Extenstion
extension HoneyToDo: Equatable {
    static func == (lhs: HoneyToDo, rhs: HoneyToDo) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

