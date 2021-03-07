//
//  Date+Short.swift
//  Phi
//
//  Created by Lo on 05/03/21.
//

import Foundation

extension String {
    
    var asDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.date(from: self)
    }
    
    var short: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        guard let date = self.asDate else { return nil }
        return formatter.string(from: date)
    }
    
    var long: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy - HH:mm:SS"
        guard let date = self.asDate else { return nil }
        return formatter.string(from: date)
    }
    
}
