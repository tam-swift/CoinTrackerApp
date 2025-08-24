//
//  Coin.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 02.08.2025.
//

// CoinGecko API info
/*
    
 URL:
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=ru&precision=full
 
 JSON Response:
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Биткоин",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 114569.91040050802,
     "market_cap": 2279928406593,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 2279930926910,
     "total_volume": 24953424306,
     "high_24h": 114869,
     "low_24h": 113582,
     "price_change_24h": 988.28,
     "price_change_percentage_24h": 0.8701,
     "market_cap_change_24h": 19227747185,
     "market_cap_change_percentage_24h": 0.85052,
     "circulating_supply": 19901637,
     "total_supply": 19901659,
     "max_supply": 21000000,
     "ath": 122838,
     "ath_change_percentage": -6.79745,
     "ath_date": "2025-07-14T07:56:01.937Z",
     "atl": 67.81,
     "atl_change_percentage": 168739.14877,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2025-08-04T08:45:53.929Z",
     "sparkline_in_7d": {
       "price": [
         119568.35054365265,
         119397.76938174861,
         118939.05286000959,
         119009.98465153869,
         118930.20208901197,
         118759.96982107592,
         118804.82575621677,
         118828.90710731824,
         118412.8584215169,
         117997.89804153176,
       ]
     },
     "price_change_percentage_24h_in_currency": 0.8701024923356038
   }
*/

import Foundation

struct Coin: Identifiable, Codable{
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings : Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image, ath, atl, currentHoldings
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case lastUpdated = "last_updated"
        case atlDate = "atl_date"
        case atlChangePercentage = "atl_change_percentage"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
    }
    
    func updateHoldings(amount: Double) -> Coin {
        return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D : Codable{
    let price: [Double]?
}
