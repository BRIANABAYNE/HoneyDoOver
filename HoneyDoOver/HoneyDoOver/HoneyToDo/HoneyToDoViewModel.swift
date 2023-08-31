//
//  HoneyToDoViewModel.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import Foundation

// playlist 
class HoneyToViewController {
    
    // MARK: - Properties
    
    var viewModel: HoneyDoViewModel!

//    var completedHoneyToDo: [HoneyToDo] {
//        honeyToDos.filter({!$0.isFinished})
//    }
    
    
//    init() {
//        load()
//    }
    
    // MARK: - Functions
    
  func createTask(for honeyToDo: TaskToDo, task: String) {
        let taskToDo = Task(honeyDo: task)
        honeyToDo.placeHolders.append(taskToDo)
//       save()
    }
    
    
    func deleteTask(task: Task, from honeyToDo: TaskToDo) {
        guard let index = honeyToDo.taskToDos.firstIndex(of: task) else { return }
        honeyToDo.taskToDos.remove(at: index)
//        save()
    }
    
//    //
//    func toggleIsFinished(honeyToDo: HoneyToDo) {
//        honeyToDos.forEach{ $0.isFinished = true}
//        save()
//    }
////    func allToggledFinished(honeyToDo: HoneyToDo) {
////        completedHoneyToDo.forEach($0.isFinished = true}
////    }
//
////    func toggleFinished() {
////        honeyToDos.forEach{ $0.isFinished = false}
////    }
//
//    func markAllFinished() {
//        honeyToDos.forEach {$0.isFinished = true}
//    }
//
//    func markAllNotFinished() {
//        honeyToDos.forEach { $0.isFinished = false }
//    }
    
    
//    // MARK: - Persistence
//    // writing
//    func save() {
//        guard let url = fileURL else {return}
//        do {
//            let data = try JSONEncoder().encode(honeyToDos)
//            try data.write(to: url)
//        } catch {
//            print(error)
//        }
//    }
//
//    func load() {
//        guard let url = fileURL else { return }
//        do {
//            let data = try Data(contentsOf: url)
//            let honeyToDo = try JSONDecoder().decode([HoneyToDo].self, from: data)
//            self.honeyToDos = honeyToDo
//        } catch {
//            print(error)
//        }
//    }
//
//    private var fileURL: URL? {
//        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        else { return nil }
//        let url = documentsDirectory.appendingPathComponent("honeyToDo.json")
//        return url
//    }

    
} // end of viewModel
