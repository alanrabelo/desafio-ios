//
//  Date+Short.swift
//  Phi
//
//  Created by Lo on 05/03/21.
//

import Foundation

extension String {
    var short: String {
        let dateString = String(self.split(separator: "T")[0])
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        //"2020-11-29T03:00:00Z"
        formatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let date = formatter.date(from: dateString) else { return "Unknown Date" }
        
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: date)
    }
}
