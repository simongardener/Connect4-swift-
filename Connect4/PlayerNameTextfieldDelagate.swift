//
//  PlayerNameTextfieldDelagate.swift
//  Connect4
//
//  Created by Simon Gardener on 04/07/2017.
//  Copyright © 2017 Simon Gardener. All rights reserved.
//

import UIKit

class PlayerNameTextfieldDelagate: NSObject, UITextFieldDelegate { 
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        var playerArray = UserDefaults.standard.array(forKey:"PlayerNames") as? [String] ?? ["Mr Yellow", "Mr Red"]
        if textField.text == "" {
            textField.text = playerArray[textField.tag]
        }else {
            playerArray[textField.tag] = textField.text!
            UserDefaults.standard.setValue(playerArray, forKey: "PlayerNames")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n"{
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
}
