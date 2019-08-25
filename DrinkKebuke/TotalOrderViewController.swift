//
//  TotalOrderViewController.swift
//  DrinkKebuke
//
//  Created by ShopBack on 2019/8/24.
//  Copyright © 2019 Boring. All rights reserved.
//

import UIKit

struct Order: Encodable {
    var data: OrderData
}

class TotalOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var logoImageView: UIImageView!
    var storeTableViewCell : UITableViewCell!
    var cachedImageViewSize: CGRect!
    var orderData = [OrderData]()
    var totalPrice: Double = 0
    
    @IBOutlet weak var totalPriceUILabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingHFLoader: HFLoader!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        UIApplication.shared.beginIgnoringInteractionEvents()
        loadingHFLoader.startAnimation()
        setLogoImageView()
        getDataSheetDB()

    }
    
    @IBAction func callNumber(_ sender: Any) {
        if let url = URL(string: "tel://0225175510"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderData.count+2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as? TotalOrderTableViewCell, indexPath.row == 0 else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? TotalOrderTableViewCell, indexPath.row > 1 else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as? PriceTableViewCell, indexPath.row == 1 else {
                            return UITableViewCell()
                        }
                    cell.drinksUILabel.text = "總計\(orderData.count)杯"
                    cell.priceUILabel.stopRuning()
                    cell.priceUILabel.animation(0.0, toNum: totalPrice, duration: cell.priceUILabel.getTimeDurationFromNum(num: totalPrice))
                    return cell
                }
                let cellData = orderData[indexPath.row-2]
                cell.update(with: cellData)
                return cell
            }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let order = orderData[indexPath.row-2]
        let deletePrice = (Double(orderData[indexPath.row-2].price!))!
        totalPrice = totalPrice - deletePrice
        deleteDataSheetDB(orderData: order)
        orderData.remove(at: indexPath.row-2)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    

    func setLogoImageView() {
        self.logoImageView = UIImageView(image: UIImage(named: "k-logo2"))
        logoImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
        self.logoImageView.contentMode = .scaleAspectFill
        self.cachedImageViewSize = logoImageView.frame
        self.tableView.addSubview(self.logoImageView)
        self.logoImageView.center = CGPoint(x: self.view.center.x, y: self.logoImageView.center.y)
        self.tableView.sendSubviewToBack(self.logoImageView)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 280))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = -scrollView.contentOffset.y
        if y > 0 {
            self.logoImageView.frame = CGRect(x: 0, y: scrollView.contentOffset.y+90, width: self.cachedImageViewSize.size.width + y, height: self.cachedImageViewSize.size.height + y - 130)
            self.logoImageView.center = CGPoint(x: self.view.center.x, y: self.logoImageView.center.y)
        }
    }
    
    func getDataSheetDB(){
        let urlStr = "https://sheetdb.io/api/v1/8mwbo072fhly1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlStr!)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data, let contents = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]]{
                for content in contents {
                    if let data = OrderData(json: content){
                        self.orderData.append(data)
                        self.totalPrice = self.totalPrice + (Double(data.price!))!
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.loadingHFLoader.stopAnimation()
                }
            }
        }
        task.resume()
    }
    func deleteDataSheetDB(orderData: OrderData) {
        if let urlStr = "https://sheetdb.io/api/v1/8mwbo072fhly1/name/\(orderData.name!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "DELETE"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let order = Order(data: orderData)
            let jsonEncoder = JSONEncoder()
            if let data = try? jsonEncoder.encode(order) {
                let task = URLSession.shared.uploadTask(with: urlRequest, from: data) { (retData, response, error)in
                    let decoder = JSONDecoder()
                    if let retData = retData, let dic = try? decoder.decode([String: Int].self, from: retData), dic["deleted"] == 1 {
                        print("刪除成功")
                    } else {
                        print("刪除失敗")
                    }
                }
                task.resume()
            } else {
                print("刪除")
            }
        }
    }

    
    
}
