//
//  Statistic.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 08.08.2025.
//

import Foundation

struct Statistic: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let percentageChange: Double?
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

