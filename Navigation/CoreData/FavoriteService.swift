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

    init(toDoItems: [FavoriteBase] = [FavoriteBase]()) {
        self.toDoItems = toDoItems
        fetchItems()
    }
    
    private func fetchItems(){
        let request = FavoriteBase.fetchRequest()
        do {
            toDoItems = try coreDataService.context.fetch(request)
        }catch{
            print(error)
        }
    }
    
    func createItem(author:String){
        let newItem = FavoriteBase(context: coreDataService.context)
        newItem.author = author
        coreDataService.saveContext()
        fetchItems()
    }

    func deleteItem(at index:Int){
        coreDataService.context.delete(toDoItems[index])
        coreDataService.saveContext()
        fetchItems()
    }
   
    // Метод для получения всех элементов (доступен извне)
    func getAllItems() -> [FavoriteBase] {
        fetchItems()
        return toDoItems
    }

}
