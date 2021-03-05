//
//  Double+Monetary.swift
//  Phi
//
//  Created by Lo on 05/03/21.
//

import Foundation

extension Double {
    var monetary: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-BR") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        
        guard let value = self as? NSNumber, let valueString = formatter.string(from: value) else {
            return "R$ 0,00"
        }
        
        return valueString
    }
}
