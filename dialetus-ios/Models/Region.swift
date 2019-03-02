//
//  Region.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import Foundation


struct Region: Decodable {
    
    let name: String
    let total: Int
    
    
    enum CodingKeys : String, CodingKey {
        case name
        case total
    }
    
}


