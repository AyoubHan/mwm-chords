//
//  Array+Extension.swift
//  mwm-chords
//
//  Created by papuruu on 22/12/2021.
//

import Foundation
import UIKit

extension Array where Element: Hashable {

    mutating func removeDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
}
