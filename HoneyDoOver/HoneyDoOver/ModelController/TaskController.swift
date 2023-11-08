//
//  TaskController.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/30/23.
//

import Foundation

class TaskController {
    
    // MARK: - Properties 
   
    static let shared = TaskController()
  
    var mormonTasks: [TaskToDo] = []
    
    init() {
        load()
    }
    
    // MARK: - Crud Functions for Task
   
    func createTask(taskName: String) {
        let taskToDo = TaskToDo(taskToDoName: taskName)
        mormonTasks.append(taskToDo)
        save()
    }
   
    func deleteTask(doDelete: TaskToDo) {
        guard let path = mormonTasks.firstIndex(of: doDelete) else { return }
        mormonTasks.remove(at: path)
        save()
    }
    
    // MARK: - Crud Functions for TaskToDo
    
    func createTaskToComplete(toComplete: TaskToDo, taskItem: String ) {
        let dadTask = Task(taskName: taskItem)
        toComplete.taskToDos.append(dadTask)
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
   
    func save() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(mormonTasks)
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
            self.mormonTasks = task
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
