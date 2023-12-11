import CoreData
import Foundation


protocol ICoreDataService{
    var mainContext:NSManagedObjectContext{get}
    var backroundContext:NSManagedObjectContext{get}
}

final class CoreDataService:ICoreDataService{

    static let shared:ICoreDataService = CoreDataService()//синглотон нужен
    //потому что надо обращаться к одному и тому же классу
    //с одной и той же ссылкой на контейннер
    
    private init(){}
    
    private  var persistentContainer:NSPersistentContainer = { // тут просиходит сохранение данных
        let container = NSPersistentContainer(name: .coreDataBaseName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error)
                assertionFailure("load PersistentStores error ")
            }
        }
        return container
    
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    lazy var backroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    
}


private extension String{
    static let coreDataBaseName = "Model"
}
