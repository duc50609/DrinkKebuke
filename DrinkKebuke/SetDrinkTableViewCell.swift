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
        let nameTextField = nameUITextField?.text
        
        if let buttonText = selectedButton?.titleLabel!.text, selectedButton == sizeRadioButtonController!.selectedButton(){
            if selectedButton == sizeButton[1] {
                drinkDelegate?.setSize(size: buttonText, large: true)
            }
            else{
                drinkDelegate?.setSize(size: buttonText, large: false)
            }

        }
        
        else{
            drinkDelegate?.setSize(size: "", large: false)
        }
            
        if let buttonText = selectedButton?.titleLabel!.text, selectedButton == temperatureRadioButtonController!.selectedButton(){
            drinkDelegate?.setTemperature(temperature: buttonText)
        }
        else{
            drinkDelegate?.setTemperature(temperature: "")
        }
            
        if let buttonText = selectedButton?.titleLabel!.text, selectedButton == sweetRadioButtonController!.selectedButton(){
            drinkDelegate?.setSweet(sweet: buttonText)
        }
            
        else{
            drinkDelegate?.setSweet(sweet: "")
        }
            
        if selectedButton == addRadioButtonController!.selectedButton(), let buttonText = selectedButton?.titleLabel!.text{
            if selectedButton == addButton[1] {
                drinkDelegate?.setAdd(add: buttonText, need: true)
            }
            else{
                drinkDelegate?.setAdd(add: buttonText, need: false)
            }

        }
        else{
            drinkDelegate?.setAdd(add: "", need: false)
        }
    
        
        drinkDelegate?.setAddOrderButton(name: nameTextField!)
        //temperatureRadioButtonController?.selectedButton(Q1UITextField
    }

}

