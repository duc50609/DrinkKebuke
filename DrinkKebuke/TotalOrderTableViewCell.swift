//
//  TotalOrderTableViewCell.swift
//  DrinkKebuke
//
//  Created by ShopBack on 2019/8/24.
//  Copyright © 2019 Boring. All rights reserved.
//

import UIKit
import AVFoundation





class TotalOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var nameUILabel: UILabel!
    @IBOutlet weak var teaUILabel: UILabel!
    @IBOutlet weak var sizeUILabel: UILabel!
    @IBOutlet weak var sweetUILabel: UILabel!
    @IBOutlet weak var temperatureUILabel: UILabel!
    @IBOutlet weak var addUILabel: UILabel!
    @IBOutlet weak var priceUILabel: UILabel!
    @IBOutlet weak var teaUIImagerView: UIImageView!
    @IBOutlet weak var speakUIbutton: UIButton!
    
    var totalPrice: Double = 0
    var orderSpeak: String = ""
    
    @IBAction func voiceSpeak(_ sender: Any) {
        let speechUtterance =  AVSpeechUtterance(string: orderSpeak)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        let synth = AVSpeechSynthesizer()
        synth.speak(speechUtterance)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(with cellData: OrderData) {
        let teaVariant = cellData.teaVariant!
        var addon = cellData.addon!
        let price = cellData.price!
        var image: UIImage?
        let mailPattern = "[\\u4e00-\\u9fa5]+"
        let pattern = "([\\u4e00-\\u9fa5]+)"
        let regex = try! Regex(pattern)
        
        if addon == "無"{
            addUILabel.text = ""
        }
        else{
            addUILabel.text = "*加： " + addon
        }
        
        switch teaVariant {
            case "熟成紅茶 Signature Black Tea":
                image = UIImage(named: "tea-1")
            case "麗春紅茶 Li-Chun Black Tea":
                image = UIImage(named: "tea-2")
            case "太妃紅茶 Toffee Black Tea":
                image = UIImage(named: "tea-3")
            case "熟成冷露 Handmade White Gourd Tea":
                image = UIImage(named: "tea-4")
            case "雪花冷露 Handmade White Gourd Drink":
                image = UIImage(named: "tea-5")
            case "春芽冷露 Handmade White Gourd Green Tea":
                image = UIImage(named: "tea-6")
            case "春芽綠茶 Green Tea":
                image = UIImage(named: "tea-7")
            case "春梅冰茶 White Gourd Drinks with Plum":
                image = UIImage(named: "tea-8")
            case "冷露歐蕾 White Gourd Drinks with Fresh Milk":
                image = UIImage(named: "tea-9")
            case "熟成歐蕾 Fresh Milk Tea":
                image = UIImage(named: "tea-10")
            case "白玉歐蕾 Milk Tea with White Tapioca":
                image = UIImage(named: "tea-11")
            case "熟成檸果 Lemon Black Tea":
                image = UIImage(named: "tea-12")
            default:
                print("Error")
        }
        
        if addon != "無" {
            addon = "加\(regex.firstMatch(in: cellData.addon!)!.string)"
        }
            
        else{
            addon = ""
        }
        
        orderSpeak = regex.firstMatch(in: teaVariant)!.string + regex.firstMatch(in: cellData.size!)!.string + regex.firstMatch(in: cellData.sugarLevel!)!.string + regex.firstMatch(in: cellData.temperature!)!.string + addon
        
        teaUIImagerView.image = image
        nameUILabel.text = "    訂購人： " + cellData.name!
        teaUILabel.text = cellData.teaVariant
        sizeUILabel.text = cellData.size
        sweetUILabel.text = cellData.sugarLevel
        temperatureUILabel.text = cellData.temperature
        priceUILabel.text = "NT$" + cellData.price!
    }
}
 

