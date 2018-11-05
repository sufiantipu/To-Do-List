//
//  File.swift
//  To Do List
//
//  Created by Brisk on 10/23/18.
//  Copyright © 2018 Brisk. All rights reserved.
//

import Foundation


class DataManager {
    class func save(list: List) {
//        let filePath = savedFilePath()
        let data = NSKeyedArchiver.archivedData(withRootObject: list)
        UserDefaults.standard.set(data, forKey: "listData")
        
    }
    
    class func getList() -> List? {
        guard let data = UserDefaults.standard.object(forKey: "listData") as? Data, let list = NSKeyedUnarchiver.unarchiveObject(with: data) as? List else {
            return nil
        }
        return list
    }
    
}
