import UIKit

var str = "Hello, playground"

let dateString = "2020-11-26T03:00:00Z"
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
dateFormatter.date(from: dateString)
