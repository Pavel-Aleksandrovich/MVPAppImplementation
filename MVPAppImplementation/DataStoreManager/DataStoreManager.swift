//
//  DataStoreManager.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 15.02.2022.
//

import Foundation
import CoreData

class DataStoreManager {
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MVPAppImplementation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: - CRUD
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func obtainTask() -> Task {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
//        fetchRequest.predicate = NSPredicate(format: "")
        
        if let task = try? viewContext.fetch(fetchRequest) as? [Task] {
            return task.first!
        } else {
            
            let task = Task(context: viewContext)
            task.title = "title"
            
            do {
                try viewContext.save()
            } catch let error {
                print("\(error)")
            }
            return task
        }
    }
    
    func updateTask(with title: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        if let task = try? viewContext.fetch(fetchRequest) as? [Task] {
            
            guard let mainTask = task.first else { return }
            
            mainTask.title = title
            
            do {
                try viewContext.save()
            } catch let error {
                print("\(error)")
            }
        }
    }
    
    func removeTask() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        if let task = try? viewContext.fetch(fetchRequest) as? [Task] {
            
            guard let mainTask = task.first else { return }
            
            viewContext.delete(mainTask)
            
            try? viewContext.save()
        }
    }
}
