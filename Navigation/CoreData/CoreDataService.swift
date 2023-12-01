import CoreData
import Foundation


protocol ICoreDataService{
    var context: NSManagedObjectContext{get}
    func saveContext()
}

final class CoreDataService:ICoreDataService{
   
    static let shared:ICoreDataService = CoreDataService()//синглотон нужен
    //потому что надо обращаться к одному и тому же классу
    //с одной и той же ссылкой на контейннер
    
    private init(){}
    
    private let persistentContainer:NSPersistentContainer = { // тут просиходит сохранение данных
        let container = NSPersistentContainer(name: .coreDataBaseName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error)
                assertionFailure("load PersistentStores error ")
            }
        }
        return container
    
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext //тут будет храниться
    }()
    
    func saveContext() {
        if context.hasChanges{
            do{
                try context.save() // если в контексте есть изменения, то мы сохраняем
            }catch{
                print(error)
                assertionFailure("Save Error")
            }
        }
    }
    
    
}


private extension String{
    static let coreDataBaseName = "Model"
}
