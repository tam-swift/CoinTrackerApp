//
//  Double.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 04.08.2025.
//

import Foundation

extension Double {
    /// Converts a Double into a Currency with 2 decimal places
    ///  ```
    ///  1234.56 -> $1,234.56
    ///  ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "$"
        formatter.currencyCode = "usd"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    /// Converts a Double into a Currency with 2-4 decimal places
    ///  ```
    ///  1234.56 -> $1,234.56
    ///  12.3456 -> $12.3456
    ///  0.123456 -> $0.1234
    ///  ```
    private var currencyFormatter4: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "$"
        formatter.currencyCode = "usd"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 4
        return formatter
    }
    
    /// Converts a Double into a Currency with 2-6 decimal places
    ///  ```
    ///  1234.56 -> $1,234.56
    ///  12.3456 -> $12.3456
    ///  0.123456 -> $0.123456
    ///  ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "$"
        formatter.currencyCode = "usd"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converts a Double into a Currency as a String with 2-6 decimal places
    ///  ```
    ///  1234.567 -> "$1234.56"
    ///  2.345678 -> "$2.3456"
    ///  1.00000212 -> "$1.000002"
    ///  ```
    func asCurrencyWith246Decimals() -> String {
        let number = NSNumber(value: self)
        switch self  {
            case 2..<10: return currencyFormatter4.string(from: number) ?? "$0.00"
            case 0..<2: return currencyFormatter6.string(from: number) ?? "$0.00"
            default: return currencyFormatter2.string(from: number) ?? "$0.00"
        }
    }
    
    /// Converts a Double into string representation
    ///  ```
    ///  1.2356 -> "1.23"
    ///  ```
    func asNumberString() -> String {
        guard
            abs(self) >= 0.01 else {return "0.00"}
            
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into string representation
    ///  ```
    ///  1.2356 -> "1.23%"
    ///  ```
    func asPercentString() -> String{
        return asNumberString() + "%"
    }
    
    /// Converts a Double to a String with a chevron from sf symbols
    ///  ```
    ///  1.235678 -> "chevron.up"
    ///  -34.56 -> "chevron.down.2"
    ///  ```
    func getChevron() -> String {
        if self >= 0.01 && self < 20 {
            return "chevron.up"
        } else if self >= 20 {
            return "chevron.up.2"
        } else if self <= -0.01 && self > -20 {
            return "chevron.down"
        } else if self < -20 {
            return "chevron.down.2"
        } else {
            return ""
        }
    }
    
    /// Formatter for reducing numbers into billions (B) and trillions (T):
    /// ```
    /// 123.456.789.123.456 -> 123.45T
    /// 123.456.789.123 -> 123.45B
    /// 123.456.789 -> 123.45M
    /// 123.456 -> 123.45K
    /// 123 -> 123
    /// ```
    func asShortenedString() -> String {
            let absValue = abs(self)
            let sign = self < 0 ? "-" : ""
            
            switch absValue {
            case 1_000_000_000_000...:
                let value = absValue / 1_000_000_000_000
                return "\(sign)\(String(format: "%.2f", value))T"
            case 1_000_000_000...:
                let value = absValue / 1_000_000_000
                return "\(sign)\(String(format: "%.2f", value))B"
            case 1_000_000...:
                let value = absValue / 1_000_000
                return "\(sign)\(String(format: "%.2f", value))M"
            case 1_000...:
                let value = absValue / 1_000
                return "\(sign)\(String(format: "%.2f", value))K"
            default:
                return "\(sign)\(String(format: "%.6f", self))"
            }
        }
}


