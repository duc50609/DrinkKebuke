//
//  ForSheetDBJson.swift
//  DrinkKebuke
//
//  Created by ShopBack on 2019/8/24.
//  Copyright © 2019 Boring. All rights reserved.
//

import Foundation

struct OrderData: Codable {
    var name: String?
    var teaVariant: String?
    var sugarLevel: String?
    var temperature: String?
    var size: String?
    var addon: String?
    var price: String?
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let teaVariant = json["teaVariant"] as? String,
            let sugarLevel = json["sugarLevel"] as? String,
            let temperature = json["temperature"] as? String,
            let size = json["size"] as? String,
            let addon = json["addon"] as? String,
            let price = json["price"] as? String
        
        else{
             return nil
        }
        
        self.name = name
        self.teaVariant = teaVariant
        self.sugarLevel = sugarLevel
        self.temperature = temperature
        self.size = size
        self.addon = addon
        self.price = price

    }
}
