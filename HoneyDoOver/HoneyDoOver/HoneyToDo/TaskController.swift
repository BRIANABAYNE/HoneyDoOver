//
//  TaskController.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/30/23.
//

import Foundation


class TaskController {
    
    
    
    static let shared = TaskController()
    
    
    var mormonTask: [TaskToDo] = []
    
   // MARK: - Crud Functions for Task
    
    
    
    
    
    
    
    
    
    
    // MARK: - Crub Functions for TaskToDo
    
    func createTask(taskName: String) {
        let taskToDo = TaskToDo(taskToDoName: taskName)
        mormonTask.append(taskToDo)
        save()
    }
    
    func deleteTask(doDelete: TaskToDo) {
        guard let path = mormonTask.firstIndex(of: doDelete) else { return }
        mormonTask.remove(at: path)
    }
    
    // MARK: - Toggle
    func toggleTaskToFinish(for task: TaskToDo) {
        TaskToDo.forEach{ $0.isFinished = true }
    }
    
    
    
    
    
  
    // MARK: - Persistence
    // writing
    func save() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(TaskToDo)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func load() {
        guard let url = fileURL else { return }
        do {
            let data = try Data(contentsOf: url)
            let task = try JSONDecoder().decode([TaskToDo].self, from: data)
            self.mormonTask = task
        } catch {
            print(error)
        }
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = documentsDirectory.appendingPathComponent("tasks.json")
        return url
    }
    
    
    
    
    
}
