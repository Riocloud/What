//
//  GoogleVision.swift
//  What
//
//  Created by Will on 12/15/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation

struct GoogleVision: Decodable {
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case description
    }
}
