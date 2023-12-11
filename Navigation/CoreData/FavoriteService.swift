//
//  FavoriteService.swift
//  Navigation
//
//  Created by Никита  on 30.11.2023.
//

import Foundation
import CoreData

class FavoriteService{
  
    private let coreDataService:ICoreDataService = CoreDataService.shared
    //тут будет происходить сохранение в нашу кордату

    private (set) var toDoItems = [FavoriteBase]()

    
    func filterItemsByAuthor(_ author: String) -> [FavoriteBase] {
        let filteredItems = toDoItems.filter { $0.author == author }
        return filteredItems
    }

    func getAllItems() -> [FavoriteBase] {
        return toDoItems
        
    }

    
    private func fetch(completion: @escaping ([FavoriteBase]) -> Void) {
        coreDataService.backroundContext.perform { [weak self] in
            guard let self = self else { return }
            let request = FavoriteBase.fetchRequest()
            
            do {
                toDoItems = try self.coreDataService.backroundContext.fetch(request).map { $0 }
                self.coreDataService.mainContext.perform { [weak self] in
                    guard let self else { return }
                    completion(toDoItems)
                    
                }
                
            } catch {
                print(error)
                toDoItems = []
            completion(toDoItems)
            }
        }
    }
    
    func saveToDoItems(with author:String,comletion: @escaping ([FavoriteBase])->Void){
        coreDataService.backroundContext.perform { [weak self] in
            guard let self else {return}
            let favoriteBase = FavoriteBase(context: coreDataService.backroundContext)
            favoriteBase.author = author
            
            if coreDataService.backroundContext.hasChanges{
                do{
                    try coreDataService.backroundContext.save()
                    coreDataService.mainContext.perform { [weak self] in
                        guard let self else {return}
                        toDoItems.insert(contentsOf: toDoItems, at: 0)
                        comletion(toDoItems)
                    }
                }catch{
                    coreDataService.mainContext.perform{ [weak self] in
                        guard let self else {return}
                        comletion(toDoItems)
                    }
                }
            }
        }
    }
    
    func createItem(with autor:String, completion: @escaping([FavoriteBase])->Void){
        coreDataService.backroundContext.perform { [weak self] in
            guard let self else{return}
            let newItem = FavoriteBase(context: coreDataService.backroundContext)
            newItem.author = autor
            
            do{
                try coreDataService.backroundContext.save()
                coreDataService.mainContext.perform { [weak self] in
                    guard let self else {return}
                    toDoItems.insert(newItem, at: 0)
                    completion(toDoItems)
                }
            }catch{
                coreDataService.mainContext.perform { [weak self] in
                    guard let self else {return}
                    completion(toDoItems)
                }
            }
        }
    }

    func deleteItem(at index: Int, completion: @escaping ([FavoriteBase]) -> Void) {
        coreDataService.backroundContext.perform { [weak self] in
            guard let self = self else { return }
            
            guard index >= 0, index < self.toDoItems.count else {
                completion(self.toDoItems)
                return
            }
            
            let itemToDelete = self.toDoItems[index]
            self.coreDataService.backroundContext.delete(itemToDelete)
            
            do {
                try self.coreDataService.backroundContext.save()
                
                self.coreDataService.mainContext.perform { [weak self] in
                    guard let self = self else { return }
                    
                    // Fetch the updated data after deletion
                    self.fetch { updatedItems in
                        completion(updatedItems)
                    }
                }
            } catch {
                print("Error deleting item: \(error)")
                
                self.coreDataService.mainContext.perform { [weak self] in
                    guard let self = self else { return }
                    completion(self.toDoItems)
                }
            }
        }
    }

   
   //  Метод для получения всех элементов (доступен извне)
    func getAllItems(completion: @escaping ([FavoriteBase]) -> Void) {
        fetch { [weak self] items in
            // No need for optional binding since self is not optional
            completion(self?.toDoItems ?? [])
        }
    }


}
