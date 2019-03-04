//
//  CardTableViewCell.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMeanTitle: UILabel!
    @IBOutlet weak var lblMeanContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    } 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = 4.0
        cardView.clipsToBounds = true
        
        contentView.layer.masksToBounds = true
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.3
    }
    
    func setup(with dialect: Dialect){
        
        lblTitle.text = dialect.dialect
        lblMeanTitle.text = "Significado"
        lblMeanContent.text = dialect.meanings.joined(separator: "\n")
    }
    
}
