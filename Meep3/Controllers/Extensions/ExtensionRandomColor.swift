//
//  ExtensionRandomColor.swift
//  Meep3
//
//  Created by Jorge Fuentes Casillas on 10/07/20.
//  Copyright © 2020 Jorge Fuentes Casillas. All rights reserved.
//

import UIKit


// MARK: - This extension helps to create a random color.
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
