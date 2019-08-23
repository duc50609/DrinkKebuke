//
//  DrinkTeaTypeTableViewCell.swift
//  DrinkKebuke
//
//  Created by ShopBack on 2019/8/21.
//  Copyright © 2019 Boring. All rights reserved.
//

import UIKit

class DrinkTeaTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameUILabel: UILabel!
    @IBOutlet weak var contentUILabel: UILabel!
    @IBOutlet weak var eng_contentUILabel: UILabel!
    @IBOutlet weak var priceUILabel: UILabel!
    @IBOutlet weak var imageUIImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with cellData: DrinkData) {
        nameUILabel.text = cellData.name
        contentUILabel.text = cellData.content
        eng_contentUILabel.text = cellData.eng_content
        priceUILabel.text = cellData.price
        imageUIImageView.image = UIImage(named: cellData.image!)
    }
}
