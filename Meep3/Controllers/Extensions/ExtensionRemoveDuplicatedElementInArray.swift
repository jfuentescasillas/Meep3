//
//  ExtensionRemoveDuplicatedElementInArray.swift
//  Meep3
//
//  Created by Jorge Fuentes Casillas on 10/07/20.
//  Copyright © 2020 Jorge Fuentes Casillas. All rights reserved.
//

import UIKit


// MARK: - Remove duplicated elements from an array (useful for the companyZoneID)
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

	
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
