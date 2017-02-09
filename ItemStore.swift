//
//  ItemStore.swift
//  Homepwner
//
//  Created by Toph on 1/15/17.
//  Copyright © 2017 Toph. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    let itemArchiveURL: URL = {
        
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentDirectory = documentDirectories.first!
        
        return documentDirectory.appendingPathComponent("item.archive") as URL
        
    }()
    
    
    init() {
        
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) {
            
            allItems += archivedItems as! [Item]
            
        }
        
    }
    
    func createItem() -> Item {
        
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
        
    }
    
    func removeItem(item: Item) {
        
        if let index = allItems.index(of: item) {
            
            allItems.remove(at: index)
            
        }
        
    }
    
    func moveItemAtIndex(_ fromIndex: Int, toIndex: Int) {
        
        if fromIndex == toIndex {
            
            return
            
        }
        
        let movedItem = allItems[fromIndex]
        
        // Remove item from array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
        
    }
    
    
    func saveChanges() -> Bool {
        
        print("Saving items to : \(itemArchiveURL.path)")
        
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
        
    }
    
}
