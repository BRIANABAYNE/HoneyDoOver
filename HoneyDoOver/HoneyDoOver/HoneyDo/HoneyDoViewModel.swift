//
//  HoneyDoViewModel.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation


class HoneyDoViewModel {
    
    // MARK: - Properties
    var honeyDos: [HoneyDo] = []
    
    
    // MARK: - Functions
    
    func create(honeyDo: String) {
        let honeyDo = HoneyDo(honeyDo: honeyDo)
        honeyDos.append(honeyDo)
    }
    
    func delete(honeyDo: HoneyDo) {
        guard let index = honeyDos.firstIndex(of: honeyDo) else { return }
        honeyDos.remove(at: index)
    }
    
    func toggleIsDone(honeyDo: HoneyDo) {
        honeyDo.isDone.toggle()
        
    }
    
    func markAllDone() {
        honeyDos.forEach { $0.isDone = true }
    }
    
    func markAllNotDone() {
        honeyDos.forEach { $0.isDone = false }
    }
    // MARK: - Persistence
    // writing
    func save() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(honeyDos)
            try data.write(to: url)
        } catch {
            print("Save didn't work")
        }
    }
    
    func load() {
        guard let url = fileURL else { return }
        do {
            let data = try Data(contentsOf: url)
            let honeyDo = try JSONDecoder().decode([HoneyDo].self, from: data)
            self.honeyDos = honeyDo
        } catch {
            print("Load didn't work")
        }
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = documentsDirectory.appendingPathComponent("honeyDo.json")
        return url
    }
    
} // end of ViewModel
