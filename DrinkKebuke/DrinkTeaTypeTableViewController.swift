//
//  DrinkTeaTypeTableViewController.swift
//  DrinkKebuke
//
//  Created by ShopBack on 2019/8/21.
//  Copyright © 2019 Boring. All rights reserved.
//

import UIKit

class DrinkTeaTypeTableViewController: UITableViewController {
    var logoImageView: UIImageView!
    var cachedImageViewSize: CGRect!
    
    let cellContent = [
        DrinkData(image: "tea-1", name: "熟成紅茶 Signature Black Tea", price: "$35.00", content: "解炸物或烤肉類油膩。果香。", eng_content: "Remove greasy of deep-fried food or grilled meat. Fruit scent."),
        DrinkData(image: "tea-2", name: "麗春紅茶 Li-Chun Black Tea", price: "$35.00", content: "去除海鮮羶腥。花香。", eng_content: "Remove fishy of seafood. Flower scent."),
        DrinkData(image: "tea-3", name: "太妃紅茶 Toffee Black Tea", price: "$45.00", content: "咖啡及茶。", eng_content: "Coffee and tea."),
        DrinkData(image: "tea-4", name: "熟成冷露 Handmade White Gourd Tea", price: "35.00", content: "手工冬瓜及茶。", eng_content: "Handmade white gourd drinks and tea."),
        DrinkData(image: "tea-5", name: "雪花冷露 Handmade White Gourd Drink", price: "$35.00", content: "手工冬瓜。", eng_content: "Handmade white gourd drinks."),
        DrinkData(image: "tea-6", name: "春芽冷露 Handmade White Gourd Green Tea", price: "$35.00", content: "手工冬瓜及綠茶。", eng_content: ""),
        DrinkData(image: "tea-7", name: "春芽綠茶 Green Tea", price: "$35.00", content: "綠茶，系系中帶點彔彔。", eng_content: ""),
        DrinkData(image: "tea-8", name: "春梅冰茶 White Gourd Drinks with Plum", price: "$45.00", content: "春梅與冬瓜相遇。", eng_content: ""),
        DrinkData(image: "tea-9", name: "冷露歐蕾 White Gourd Drinks with Fresh Milk", price: "50.00", content: "手工冬瓜及鮮奶。", eng_content: "Handmade white gourd drinks and fresh milk."),
        DrinkData(image: "tea-10", name: "熟成歐蕾 Fresh Milk Tea", price: "$50.00", content: "鮮奶茶。", eng_content: "Fresh milk tea."),
        DrinkData(image: "tea-11", name: "白玉歐蕾 Milk Tea with White Tapioca", price: "$60.00", content: "白玉珍珠奶茶。", eng_content: "Milk tea with white tapioca."),
        DrinkData(image: "tea-12", name: "熟成檸果 Lemon Black Tea", price: "$60.00", content: "中杯。每日限量。搭配少糖最佳。冷飲。", eng_content: "Medium. Daily limited. Suggest sweetness level with 70% sugar. Cold drinks.")

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLogoImageView()

    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
                let y: CGFloat = -scrollView.contentOffset.y
                if y > 0 {
                    self.logoImageView.frame = CGRect(x: 0, y: scrollView.contentOffset.y+90, width: self.cachedImageViewSize.size.width + y, height: self.cachedImageViewSize.size.height + y - 130)
                    self.logoImageView.center = CGPoint(x: self.view.center.x, y: self.logoImageView.center.y)
                }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellContent.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as? DrinkTeaTypeTableViewCell
            else {
                return UITableViewCell()
        }
        let cellData = cellContent[indexPath.row]
        cell.update(with: cellData)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SetOrderViewController, let _ = tableView.indexPathForSelectedRow?.section, let row = tableView.indexPathForSelectedRow?.row {
                controller.cellData = cellContent[row]
            }
    }
    
    func setLogoImageView() {
        self.logoImageView = UIImageView(image: UIImage(named: "k-logo"))
        logoImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
        self.logoImageView.contentMode = .scaleAspectFill
        self.cachedImageViewSize = logoImageView.frame
        self.tableView.addSubview(self.logoImageView)
        self.logoImageView.center = CGPoint(x: self.view.center.x, y: self.logoImageView.center.y)
        self.tableView.sendSubviewToBack(self.logoImageView)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 280))
    }
}
