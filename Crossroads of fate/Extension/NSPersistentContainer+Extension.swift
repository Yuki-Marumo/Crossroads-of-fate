//
//  NSPersistentContainer+Extension.swift
//  Crossroads of fate
//
//  Created by 丸茂優輝 on 2022/05/04.
//

import CoreData

extension NSPersistentContainer {
    
    func saveContext() {
        saveContext(context: viewContext)
    }
    
    func saveContext(context: NSManagedObjectContext) {
        guard context.hasChanges else {
            // 変更がない場合、何もしない
            return
        }
        
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
