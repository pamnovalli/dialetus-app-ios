//
//  Dialect.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import Foundation

struct Dialect: Decodable  {
    
    let slug: String
    let dialect: String
    let meanings: [String]
    let examples: [String]
    
    enum CodingKeys : String, CodingKey {
        case slug
        case dialect
        case meanings
        case examples
    }
}
