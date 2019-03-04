//
//  DetailViewModel.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import Foundation


class DetailViewModel {
    
    let dialect: Dialect
    
    var examples: [String] {
        return dialect.examples
    }
    
    init(dialect: Dialect){
        self.dialect = dialect
    }
    
    
    
}
