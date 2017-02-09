//
//  Item.swift
//  Homepwner
//
//  Created by Toph on 1/15/17.
//  Copyright © 2017 Toph. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    
    let dateCreated: Date
    let itemKey: String
    
    required init?(coder aDecoder: NSCoder) {
        
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as! String?
        
        valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
        
        super.init()
        
    }
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = Date()
        self.itemKey = NSUUID().uuidString
        
        super.init()
        
    }
    
    convenience init(random: Bool = false) {
        
        if random {
            
            let adjectives = ["Dirty", "Flimsy", "Slutty"]
            let nouns = ["Woman", "Man", "Hermaphrodite"]
            
            var idx = arc4random_uniform(uint(nouns.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(uint(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
        }
        
        else {
            
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
            
        }
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(itemKey, forKey: "itemKey")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
        
    }
}
