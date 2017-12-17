//
//  squareStruct.swift
//  What
//
//  Created by Will on 12/15/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation
import Foundation
struct Root: Codable {
    
    let responses: [Responses]
    
}

struct Responses: Codable {
    
    let labelAnnotations: [LabelAnnotations]
    
}

struct LabelAnnotations: Codable {
    
    let mid: String
    let description: String
    let score: Double
    
}
