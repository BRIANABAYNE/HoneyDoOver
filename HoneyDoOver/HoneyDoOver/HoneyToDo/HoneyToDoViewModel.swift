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
    
    init() {
        load()
    }
    
    // MARK: - Functions
    
    func create(honeyToDo: String) {
        let honeyToDo = HoneyToDo(honeyToDo: honeyToDo)
        honeyToDos.append(honeyToDo)
        save()
    }
    
    
    func delete(honeyToDo: HoneyToDo) {
        guard let index = honeyToDos.firstIndex(of: honeyToDo) else { return }
        honeyToDos.remove(at: index)
        save()
    }
    
    
    func toggleIsFinished(honeyToDo: HoneyToDo) {
        honeyToDos.forEach{ $0.isFinished = true}
    }
    
//    func toggleFinished() {
//        honeyToDos.forEach{ $0.isFinished = false}
//    }
    
    func markAllFinished() {
        honeyToDos.forEach {$0.isFinished = true}
    }
    
    func markAllNotFinished() {
        honeyToDos.forEach { $0.isFinished = false }
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
