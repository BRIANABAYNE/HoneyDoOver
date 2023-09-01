//
//  TaskController.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/30/23.
//

import Foundation


class TaskController {
    
    
    // MARK: - Properties - SST
    static let shared = TaskController()
    // Singlton
    var mormonTask: [TaskToDo] = []
    
   // - init for the class + Calling the load for JSON
    init() {
        load()
    }
    
    // MARK: - Crud Functions for Task


    func createTask(taskName: String) {
        let taskToDo = TaskToDo(taskToDoName: taskName)
        mormonTask.append(taskToDo)
        save()
    }
    
    func deleteTask(doDelete: TaskToDo) {
        guard let path = mormonTask.firstIndex(of: doDelete) else { return }
        mormonTask.remove(at: path)
        save()
    }
    
    // MARK: - Crub Functions for TaskToDo
    
    func createTaskToComplete(toComplete: TaskToDo, taskItem: String ) {
        let dadTask = Task(taskName: taskItem)
        toComplete.taskToDos.append(dadTask)
        save()
    }
    
    func updateTask(task: Task, newTask: String) {
        task.taskName = newTask
        save()
    }
    
    func deleteCompeletedTask(task: Task, toDoTasks: TaskToDo) {
        guard let index = toDoTasks.taskToDos.firstIndex(of: task) else { return }
        toDoTasks.taskToDos.remove(at: index)
        save()
        
    }
    
    // MARK: - Toggle
    func toggleTaskToFinish(for task: Task) {
        task.isDone.toggle()
    }
    
    func toggleIsCompleted(taskToDo: TaskToDo) {
        taskToDo.isFinished.toggle()
    }
  
    // MARK: - Persistence
    // writing
    func save() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(mormonTask)
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
