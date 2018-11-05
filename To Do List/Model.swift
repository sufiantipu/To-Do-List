//
//  Model.swift
//  To Do List
//
//  Created by Brisk on 10/22/18.
//  Copyright © 2018 Brisk. All rights reserved.
//

import Foundation
import UIKit

class List: NSObject, NSCoding {
    
    var name: String!
    var subLists: [List]!
    var tasks: [Task]!
    
    init(name: String) {
        super.init()
        self.name = name
        subLists = [List]()
        tasks = [Task]()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.subLists = aDecoder.decodeObject(forKey: "subList") as! [List]
        self.tasks = aDecoder.decodeObject(forKey: "tasks") as! [Task]
    }
    
    func addNewSubList(name: String) {
        let subList = List(name: name)
        subLists.append(subList)
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(subLists, forKey: "subList")
        aCoder.encode(tasks, forKey: "tasks")
    }
    
}

class Task: NSObject, NSCoding {
    var name: String!
    var detail: String!
    var isComplete: Bool!
    var date: String!
    
    init(name: String, detail: String, date: String, isComplete: Bool) {
        super.init()
        self.name = name
        self.detail = detail
        self.isComplete = isComplete
        self.date = date
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.detail = aDecoder.decodeObject(forKey: "detail") as! String
        self.isComplete = aDecoder.decodeObject(forKey: "complete") as! Bool
        self.date = aDecoder.decodeObject(forKey: "date") as! String
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(detail, forKey: "detail")
        aCoder.encode(isComplete, forKey: "complete")
        aCoder.encode(date, forKey: "date")
    }
}
