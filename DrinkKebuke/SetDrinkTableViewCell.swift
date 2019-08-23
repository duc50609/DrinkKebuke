//
//  SetDrinkTableViewCell.swift
//  DrinkKebuke
//
//  Created by ShopBack on 2019/8/22.
//  Copyright © 2019 Boring. All rights reserved.
//

import UIKit

class SetDrinkTableViewCell: UITableViewCell, SSRadioButtonControllerDelegate {
    @IBOutlet var sizeButton: [SSRadioButton]!
    @IBOutlet var sweetButton: [SSRadioButton]!
    @IBOutlet var temperatureButton: [SSRadioButton]!
    @IBOutlet var addButton: [SSRadioButton]!
    @IBOutlet weak var nameUITextField: UITextField!
    
    var sizeRadioButtonController: SSRadioButtonsController?
    var temperatureRadioButtonController: SSRadioButtonsController?
    var sweetRadioButtonController: SSRadioButtonsController?
    var addRadioButtonController: SSRadioButtonsController?
    
    var drinkDelegate: sendProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        sizeRadioButtonController = SSRadioButtonsController(buttons: sizeButton[0], sizeButton[1])
        sizeRadioButtonController!.delegate = self
        sizeRadioButtonController!.shouldLetDeSelect = true
        
        temperatureRadioButtonController = SSRadioButtonsController(buttons: temperatureButton[0], temperatureButton[1], temperatureButton[2], temperatureButton[3], temperatureButton[4], temperatureButton[5], temperatureButton[6], temperatureButton[7], temperatureButton[8])
        temperatureRadioButtonController!.delegate = self
        temperatureRadioButtonController!.shouldLetDeSelect = true
        
        sweetRadioButtonController = SSRadioButtonsController(buttons: sweetButton[0], sweetButton[1], sweetButton[2], sweetButton[3], sweetButton[4])
        sweetRadioButtonController!.delegate = self
        sweetRadioButtonController!.shouldLetDeSelect = true
        
        addRadioButtonController = SSRadioButtonsController(buttons: addButton[0], addButton[1])
        addRadioButtonController!.delegate = self
        addRadioButtonController!.shouldLetDeSelect = true

        
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        if selectedButton == sizeRadioButtonController!.selectedButton(){
            if selectedButton == sizeButton[1] {
                drinkDelegate?.setSize(size: (selectedButton?.titleLabel!.text)!, large: true)
            }
            else{
                drinkDelegate?.setSize(size: (selectedButton?.titleLabel!.text)!, large: false)
            }

        }
            
        else if selectedButton == temperatureRadioButtonController!.selectedButton(){
            drinkDelegate?.setTemperature(temperature: (selectedButton?.titleLabel!.text)!)
        }
            
        else if selectedButton == sweetRadioButtonController!.selectedButton(){
            drinkDelegate?.setSweet(sweet: (selectedButton?.titleLabel!.text)!)
        }
            
        else if selectedButton == addRadioButtonController!.selectedButton(){
            if selectedButton == addButton[1] {
                drinkDelegate?.setAdd(add: (selectedButton?.titleLabel!.text)!, need: true)
            }
            else{
                drinkDelegate?.setAdd(add: (selectedButton?.titleLabel!.text)!, need: false)
            }

        }
        
        drinkDelegate?.setAddOrderButton(name: (nameUITextField?.text)!)
        //temperatureRadioButtonController?.selectedButton(Q1UITextField
    }

}

