//
//  PriceTableViewCell.swift
//  DrinkKebuke
//
//  Created by ShopBack on 2019/8/25.
//  Copyright © 2019 Boring. All rights reserved.
//


import UIKit

class PriceTableViewCell: UITableViewCell {
    @IBOutlet weak var drinksUILabel: UILabel!
    @IBOutlet weak var priceUILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    

}
