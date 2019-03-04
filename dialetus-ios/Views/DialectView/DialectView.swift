//
//  DialectView.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 03/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import UIKit

class DialectView: UIView {

    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblSubtitle: UILabel!
    
    func config(with dialect: Dialect) {
        
        lblTitle.text = dialect.dialect
        lblSubtitle.text = "Significado:\n\(dialect.meanings.joined(separator: "; "))"
    }
}
