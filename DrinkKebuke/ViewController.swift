//
//  ViewController.swift
//  DrinkKebuke
//
//  Created by ShopBack on 2019/8/21.
//  Copyright © 2019 Boring. All rights reserved.
//

import UIKit
import TTFortuneWheel

class ViewController: UIViewController {
    
    @IBOutlet weak var spinningWheel: TTFortuneWheel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let slices = [ CarnivalWheelSlice.init(title: "熟成紅茶"),
                       CarnivalWheelSlice.init(title: "麗春紅茶"),
                       CarnivalWheelSlice.init(title: "太妃紅茶"),
                       CarnivalWheelSlice.init(title: "熟成冷露"),
                       CarnivalWheelSlice.init(title: "雪花冷露"),
                       CarnivalWheelSlice.init(title: "春芽冷露"),
                       CarnivalWheelSlice.init(title: "春芽綠茶"),
                       CarnivalWheelSlice.init(title: "春梅冰茶"),
                       CarnivalWheelSlice.init(title: "冷露歐蕾"),
                       CarnivalWheelSlice.init(title: "熟成歐蕾"),
                       CarnivalWheelSlice.init(title: "白玉歐蕾"),
                       CarnivalWheelSlice.init(title: "熟成檸果")]
        spinningWheel.slices = slices
        spinningWheel.equalSlices = true
        spinningWheel.frameStroke.width = 0
        spinningWheel.slices.enumerated().forEach { (pair) in
            let slice = pair.element as! CarnivalWheelSlice
            let offset = pair.offset
            switch offset % 4 {
            case 0: slice.style = .brickRed
            case 1: slice.style = .sandYellow
            case 2: slice.style = .babyBlue
            case 3: slice.style = .deepBlue
            default: slice.style = .brickRed
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rotateButton(_ sender: Any) {
        var number = Int.random(in: 1...12)
        spinningWheel.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.spinningWheel.startAnimating(fininshIndex: number) { (finished) in
                print(finished)
            }
        }
    }
}
extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
