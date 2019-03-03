//
//  CardTableViewCell.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMeanTitle: UILabel!
    @IBOutlet weak var lblMeanContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    } 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(with dialect: Dialect){
        
        lblTitle.text = dialect.dialect
        lblMeanTitle.text = "Significado"
        lblMeanContent.text = dialect.meanings.joined(separator: "\n")
    }
    
}
