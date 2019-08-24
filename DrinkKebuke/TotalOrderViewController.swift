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
    var cachedImageViewSize: CGRect!
    var orderData = [OrderData]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setLogoImageView()
        getDataToSheetDB()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = -scrollView.contentOffset.y
        if y > 0 {
            self.logoImageView.frame = CGRect(x: 0, y: scrollView.contentOffset.y+90, width: self.cachedImageViewSize.size.width + y, height: self.cachedImageViewSize.size.height + y - 130)
            self.logoImageView.center = CGPoint(x: self.view.center.x, y: self.logoImageView.center.y)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? TotalOrderTableViewCell
            else {
                return UITableViewCell()
        }
        let cellData = orderData[indexPath.row]
        cell.update(with: cellData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let order = orderData[indexPath.row]
        deleteDataToSheetDB(orderData: order)
        orderData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func deleteDataToSheetDB(orderData: OrderData) {
        if let urlStr = "https://sheetdb.io/api/v1/8mwbo072fhly1/name/\(orderData.name!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "DELETE"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            print(urlStr)
            let order = Order(data: orderData)
            print(order)
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
    
    func getDataToSheetDB(){
        let urlStr = "https://sheetdb.io/api/v1/8mwbo072fhly1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlStr!)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data, let contents = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]]{
                for content in contents {
                    if let data = OrderData(json: content){
                        self.orderData.append(data)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
}
