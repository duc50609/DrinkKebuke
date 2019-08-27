//
//  SetOrderViewController.swift
//  DrinkKebuke
//
//  Created by ShopBack on 2019/8/22.
//  Copyright © 2019 Boring. All rights reserved.
//
protocol sendProtocol{
    func setSize(size: String, large: Bool)
    func setSweet(sweet: String)
    func setTemperature(temperature: String)
    func setAdd(add: String, need: Bool)
    func setAddOrderButton(name: String)
}

import UIKit

class SetOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, sendProtocol {
    
    @IBOutlet weak var addOrderUIButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceUILbel: UILabel!
    @IBOutlet weak var loagingHFLoader: HFLoader!
    

    var cellData: DrinkData?
    var size: String!
    var teaVariant : String!
    var temperature: String!
    var add: String!
    var sweet: String!
    var name: String!
    var price : Double!
    var checkSize = false
    var checkAdd = false
    

    @IBAction func addOrderUIButton(_ sender: Any) {
        teaVariant = cellData?.name
        if name != nil, size != nil, temperature != nil, add != nil, sweet != nil, name != "", size != "", temperature != "", add != "", sweet != ""{
            loagingHFLoader.alpha = 1
            UIApplication.shared.beginIgnoringInteractionEvents()
            loagingHFLoader.startAnimation()
            postDataToSheetDB()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                UIApplication.shared.endIgnoringInteractionEvents()
                self.loagingHFLoader.stopAnimation()
                let navController = self.navigationController
                self.navigationController?.popViewController(animated: false)
                navController?.viewControllers.first?.performSegue(withIdentifier: "showTotalOrder", sender: nil)
            }

        }
        else{
            let title = "訂單無法送出"
            let alertMessage = "請檢查每個欄位是否都填寫完成"
            let alertController = UIAlertController(title: title, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "確認",style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceUILbel.text = cellData?.price
        tableView.delegate = self
        tableView.dataSource = self
        price = Double((cellData?.price?.replacingOccurrences(of: "$", with: ""))!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? SetOrderTableViewCell, indexPath.row == 0 else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "setDrinkCell", for: indexPath) as? SetDrinkTableViewCell, indexPath.row == 1 else {
                return UITableViewCell()
            }
            cell.drinkDelegate = self
            return cell
        }
        cell.setCellData(with: cellData!)
        return cell
    }
    
    func postDataToSheetDB(){
        let url = URL(string: "https://sheetdb.io/api/v1/ovpbyaxyfnp82")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let orderConfig: [String : String] = ["name": name, "teaVariant": teaVariant, "sugarLevel": sweet, "temperature": temperature, "size": size, "addon": add, "price": String(price)]
        let postData: [String: Any] = ["data" : orderConfig]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: postData, options: [])
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data) { (retData, res, err) in
                NotificationCenter.default.post(name: Notification.Name("waitMessage"), object: nil, userInfo: ["message": true])
            }

            task.resume()
        }
            
        catch{
        }
        
    }
    
    func setPrice(type: String){
        let originalPrice = Double((cellData?.price?.replacingOccurrences(of: "$", with: ""))!)
        if checkAdd, checkSize{
            price = originalPrice! + 15
        }
        else if checkAdd{
            price = originalPrice! + 10
        }
        else if checkSize{
            price = originalPrice! + 5
        }
        else{
            price = originalPrice
        }
        priceUILbel.text = "$\(self.price!)0"
    }
    
    func setSize(size: String, large: Bool){
        if large, size != ""{
            self.size = size
            checkSize = true
        }
        else if size != ""{
            self.size = size
            checkSize = false
        }
        setPrice(type: "size")
    }
    
    func setSweet(sweet: String){
        if sweet != "" {
            self.sweet = sweet
        }
    }
    
    func setAdd(add: String, need: Bool){
        if need, add != ""{
            checkAdd = true
            self.add = add

        }
        else if add != ""{
            checkAdd = false
            self.add = add
        }
        setPrice(type: "add")
        
    }
    
    func setTemperature(temperature: String){
        if temperature != ""{
            self.temperature = temperature
        }
    }
    
    func setAddOrderButton(name: String){
        self.name = name
        if  temperature != nil, sweet != nil, add != nil, size != nil,name != "", size != "", temperature != "", add != "", sweet != ""{
            addOrderUIButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        
    }
}
