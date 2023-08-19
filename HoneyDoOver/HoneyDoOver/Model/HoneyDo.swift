//
//  HoneyDo.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation

class HoneyDo: Codable {
    
    var honeyDo: String
    let uuid: UUID
    var isDone: Bool
    
    
    init(honeyDo: String, uuid: UUID = UUID(), isDone: Bool = false) {
        self.honeyDo = honeyDo
        self.uuid = uuid
        self.isDone = isDone
    }
    
}

// MARK: - Extension

extension HoneyDo: Equatable {
    static func == (lhs: HoneyDo, rhs: HoneyDo) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
