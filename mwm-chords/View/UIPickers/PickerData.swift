//
//  PickerData.swift
//  mwm-chords
//
//  Created by papuruu on 22/12/2021.
//

import Foundation
import UIKit

class PickerData: NSObject {
    var toneNames: [String] = []
    var keyChords: [String] = []
}

extension PickerData: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if component == 0 {
            count = toneNames.count
        } else {
            count = keyChords.count
        }
        return count
    }
}

extension PickerData: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rowData = ""
        if component == 0 {
            rowData = toneNames[row]
        } else {
            rowData = keyChords[row]
        }
        return rowData
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(toneNames[row])
        print(keyChords[row])
    }
}
