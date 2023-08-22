//
//  HoneyDo.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation

class HoneyDo: Codable {
    // reading and writing 
    
    var honeyDo: String
    let uuid: UUID
    var isDone: Bool // for toggle 
    
    
    init(honeyDo: String, uuid: UUID = UUID(), isDone: Bool = false) {
        self.honeyDo = honeyDo
        self.uuid = uuid
        self.isDone = isDone
    }
    
}

// MARK: - Extension
// Creating a UUID every time a new HoneyDo is created - we also need this to delete 
extension HoneyDo: Equatable {
    static func == (lhs: HoneyDo, rhs: HoneyDo) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
