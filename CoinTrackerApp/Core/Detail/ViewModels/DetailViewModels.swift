//
//  DetailViewModels.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 23.08.2025.
//

import Foundation

class DetailViewModels : ObservableObject{
    
    @Published var overviewStats: [Statistic] = []
    @Published var additionalStats: [Statistic] = []
    
    let coin : Coin
    
    init(coin: Coin) {
        self.coin = coin
        getStats()
    }
    
    func getStats() {

        let price = coin.currentPrice.asCurrencyWith246Decimals()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = Statistic(title: "Цена", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coin.marketCap?.asShortenedString() ?? "")
        let marketCapChange = coin.marketCapChangePercentage24H
        let marketStat = Statistic(title: "Рын. капитализация", value: marketCap, percentageChange: marketCapChange)
        
        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: "Ранг", value: rank)
        
        let volume =  "$" + (coin.totalVolume?.asShortenedString() ?? "")
        let volumeStat = Statistic(title: "Объем", value: volume)
        
        overviewStats = [priceStat, marketStat, rankStat, volumeStat]
        
        
        let hight = coin.high24H?.asCurrencyWith246Decimals() ?? "н/д"
        let highStats = Statistic(title: "Максимум за 24ч.", value: hight)
        
        let low = coin.low24H?.asCurrencyWith246Decimals() ?? "н/д"
        let lowStat = Statistic(title: "Минимум за 24ч.", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrencyWith246Decimals() ?? "н/д"
        let pricePercentChange2 = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "Изм. цены за 24ч.", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange24H = "$" + (coin.marketCapChange24H?.asShortenedString() ?? "")
        let marketCapChangePercentage24H = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "Изм. рыночной капитализации", value: marketCapChange24H, percentageChange: marketCapChangePercentage24H)
        
        additionalStats = [highStats, lowStat, priceChangeStat, marketCapChangeStat]
    }
}
