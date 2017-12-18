//
//  PersistenceManager.swift
//  What
//
//  Created by Will on 12/18/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation

import Foundation
import CoreData
enum Path: String {
    case Public = "Public"
    case Starred = "Starred"
    case MyGists = "MyGists"
}

class PersistenceManager: NSObject {
    class private func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let documentDirectory = paths[0] as NSString
        return documentDirectory
    }
    
    class func saveArray<T: NSCoding>(arrayToSave: [T], path: Path) -> Bool {
        let file = documentsDirectory().appendingPathComponent(path.rawValue)
        return NSKeyedArchiver.archiveRootObject(arrayToSave, toFile: file)
    }
    
    class func loadArray<T: NSCoding>(path: Path) -> [T]? {
        let file = documentsDirectory().appendingPathComponent(path.rawValue)
        let result = NSKeyedUnarchiver.unarchiveObject(withFile: file)
        return result as? [T]
    }
}
