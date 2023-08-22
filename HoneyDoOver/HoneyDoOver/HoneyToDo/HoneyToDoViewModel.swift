//
//  HoneyToDoViewModel.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation


class HoneyTodDoViewModel {
    
    // MARK: - Properties
    
    var honeyToDos: [HoneyToDo] = []
    
    // MARK: - Functions
    
    func create(honeyToDo: String) {
        let honeyToDo = HoneyToDo(honeyToDo: honeyToDo)
        honeyToDos.append(honeyToDo)
    }
    
    
    func delete(honeyToDo: HoneyToDo) {
        guard let index = honeyToDos.firstIndex(of: honeyToDo) else { return }
        honeyToDos.remove(at: index)
    }
    
    
    func toggleIsFinished() {
        honeyToDos.forEach{ $0.isFinished = true}
    }
    
    func toggleFinished() {
        honeyToDos.forEach{ $0.isFinished = false}
    }
    
    func markAllFinished() {
        
    }
    
    func markAllNotFinished() {
        
    }
    
    
    // MARK: - Persistence 
    // writing
    func save() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(honeyToDos)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func load() {
        guard let url = fileURL else { return }
        do {
            let data = try Data(contentsOf: url)
            let honeyToDo = try JSONDecoder().decode([HoneyToDo].self, from: data)
            self.honeyToDos = honeyToDo
        } catch {
            print(error)
        }
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = documentsDirectory.appendingPathComponent("honeyToDo.json")
        return url
    }
    
    
    
} // end of viewModel
