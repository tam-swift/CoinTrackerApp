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
    
    /// Converts a Double into a Currency as a String with 2 decimal places
    ///  ```
    ///  1234.56 -> "$1234.56"
    ///  ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
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


