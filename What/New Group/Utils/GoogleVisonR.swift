//
//  GoogleVisonR.swift
//  What
//
//  Created by Will on 12/18/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation

class GoogleVisionR: NSObject {
    let descrip: String
    let score: Float
    
    let scoreKey = "score"
    let titleKey = "descrip"
    
    init(descrip: String, score: Float) {
        
        self.descrip = descrip
        self.score = score
    }
    
    required init?(coder aDecoder: NSCoder) {
        score = aDecoder.decodeFloat(forKey: scoreKey)
        descrip = aDecoder.decodeObject(forKey: titleKey) as! String
    }
}

extension GoogleVisionR: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(score, forKey: scoreKey)
        aCoder.encode(descrip, forKey: titleKey)
    }
}

