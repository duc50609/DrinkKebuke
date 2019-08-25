//
//  SetOrderTableViewCell.swift
//  DrinkKebuke
//
//  Created by ShopBack on 2019/8/21.
//  Copyright © 2019 Boring. All rights reserved.
//

import UIKit

class SetTitleOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var nameUILabel: UILabel!
    @IBOutlet weak var contentUILabel: UILabel!
    @IBOutlet weak var eng_contentUILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData (with cellData: DrinkData){
        nameUILabel.text = cellData.name
        contentUILabel.text = cellData.content
        eng_contentUILabel.text = cellData.eng_content
    }

}
