//
//  HoneyDo.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation

struct HoneyDo {
    
    let honeyDo: String
    let uuid: UUID = UUID()
    var isDone: Bool = false
    
}

// MARK: - Extension

extension HoneyDo: Equatable {
    static func == (lhs: HoneyDo, rhs: HoneyDo) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
