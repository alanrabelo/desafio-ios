//
//  UIColor+Named.swift
//  Phi
//
//  Created by Lo on 05/03/21.
//

import UIKit

enum PhiColors: String {
    case dark, light, green, gray
    
    var color: UIColor { UIColor(named: self.rawValue.capitalized) ?? .black }
}
