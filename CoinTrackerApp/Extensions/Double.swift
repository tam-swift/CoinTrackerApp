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
            case 0...1: return currencyFormatter6.string(from: number) ?? "$0.00"
            default: return currencyFormatter2.string(from: number) ?? "$0.00"
        }
    }
    
    /// Converts a Double into string representation
    ///  ```
    ///  1.2356 -> "1.23"
    ///  ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into string representation
    ///  ```
    ///  1.2356 -> "1.23%"
    ///  ```
    func asPercentString() -> String{
        return asNumberString() + "%"
    }
}


