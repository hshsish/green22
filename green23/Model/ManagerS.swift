
import Foundation
import SwiftUI

extension Double {
    
    func conver2DateFromUNIX() -> Date {
    var date = NSDate(timeIntervalSince1970: self)
        return date as Date
    }
    
    var convertF2C : Double {
        return ((self-32)*5/9)
    }
    
    func roundDouble(pointnum: Int) -> String {
        return String(format: "%.\(pointnum)f", self)
    }
    
    var convertK2C: Double {
        return self - 273.15
    }
    
    func visibilityText() -> String {
        var text = ""
        
        if self == 10000 {
            text = "Absolutely clear"
        }
        
        if self == 9000 {
            text = "Visibility reduced"
        }
        
        if self == 8000 {
            text = "Visibility reduced"
        }
        
        if self == 7000 {
            text = "Low visibility"
        }
        
        if self == 6000 {
            text = "Low visibility"
        }
        return text
    }
    
    func uvcalcl() -> String {
        switch self {
        case 0, 1, 2:
            return "Low"
        case 3, 4, 5:
            return "Medium"
        case 6, 7:
            return "High"
        case 8, 9, 10, 11, 12, 13, 14:
            return "Very high"
        default:
            return ""
        }
    }
    
    func toCardinalDirection() -> String {
        
        let degrees = self
        
        switch degrees {
        case 348.75...360, 0..<11.25:
            return "S"
        case 11.25..<33.75:
            return "SSW"
        case 33.75..<56.25:
            return "SW"
        case 56.25..<78.75:
            return "WSW"
        case 78.75..<101.25:
            return "W"
        case 101.25..<123.75:
            return "WNW"
        case 123.75..<146.25:
            return "NW"
        case 146.25..<168.75:
            return "NNW"
        case 168.75..<191.25:
            return "N"
        case 191.25..<213.75:
            return "NNE"
        case 213.75..<236.25:
            return "NE"
        case 236.25..<258.75:
            return "ENE"
        case 258.75..<281.25:
            return "E"
        case 281.25..<303.75:
            return "ESE"
        case 303.75..<326.25:
            return "SE"
        case 326.25..<348.75:
            return "SSE"
        default:
            return ""
        }
    }
}

extension String {
    
    func getIcon() -> String {
        
        var icon = "sun.min"
        
        if self == "partly-cloudy-day" {
            icon = "cloud.sun"
        }
        
        if self == "partly-cloudy-night" {
            icon = "cloud.moon"
        }
        
        if self == "rain"{
            icon = "cloud.drizzle"
        }
        
        if self == "cloudy"{
            icon = "cloud"
        }
        return icon
    }
    
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd "
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self) ?? Date()
    }
}

extension Date {

    func dayWord() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
    
    func hours() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        
        return dateFormatter.string(from: self)
    }
}

