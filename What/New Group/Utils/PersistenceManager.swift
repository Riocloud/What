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


class PersistenceManager{
    func get_uuid() -> String{
        let userid = UserDefaults.standard.string(forKey: "hangge")
        //判断UserDefaults中是否已经存在
        if(userid != nil){
            return userid!
        }else{
            //不存在则生成一个新的并保存
            let uuid_ref = CFUUIDCreate(nil)
            let uuid_string_ref = CFUUIDCreateString(nil , uuid_ref)
            let uuid = uuid_string_ref as! String
            UserDefaults.standard.set(uuid, forKey: "hangge")
            return uuid
        }
    }
    
   
}
