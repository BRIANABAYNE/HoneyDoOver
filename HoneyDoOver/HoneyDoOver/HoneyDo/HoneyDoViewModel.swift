//
//  HoneyDoViewModel.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation


class HoneyDoViewModel {
    
    // MARK: - Properties
    var honeyDos: [Task] = []
    
    var pendingHoneyDos: [Task] {
        honeyDos.filter({!$0.isDone})
    }
    init() { // initialzing the class of the HoneyDoViewModel
        load() // Calling the load inside of the function of the init, will load the information from our JSON persit.
    }
    
    
    // MARK: - Functions
    // Creating - Crud Function
    func create(taskNameOne: String) {
        // Creating a constaint and assigning it the value of a HoneyDo Init with of type honeyDo
        let honeyDo = Task(honeyDo: taskNameOne)
        // appending "adding" the honeyDo that I just created on line 27
        honeyDos.append(honeyDo)
        // Calling save for the JSon
        save()
    }
    
    func delete(honeyDo: Task) {
        guard let index = honeyDos.firstIndex(of: honeyDo) else { return }
        honeyDos.remove(at: index)
        save()
    }
    // This is change the status of the toggle / takse whatever the current bool is and does the opposite / Toggle is the boolan variable value.
    func toggleIsDone(honeyDo: Task) {
        honeyDo.isDone.toggle()
        save() // dont forget the save
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
            let honeyDo = try JSONDecoder().decode([Task].self, from: data)
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
