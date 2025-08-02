//
//  Coin.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 02.08.2025.
//

import Foundation

// CoinGecko API info
/*
    
 URL:
 https://pro-api.coingecko.com/api/v3/coins/markets?vs_currency=rub&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=ru&precision=full
 
 JSON Response:
 {
 "id":"bitcoin",
 "symbol":"btc",
 "name":"Биткоин",
 "image":"https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
 "current_price":9058590.952774009,
 "market_cap":180257502518177,
 "market_cap_rank":1,
 "fully_diluted_valuation":180257502518177,
 "total_volume":5319974784430,"high_24h":9471049,
 "low_24h":9061786,"price_change_24h":-402113.8576496653,
 "price_change_percentage_24h":-4.25036,"market_cap_change_24h":-7911224003265.594,
 "market_cap_change_percentage_24h":-4.20432,
 "circulating_supply":19900450.0,
 "total_supply":19900450.0,
 "max_supply":21000000.0,
 "ath":11257762,
 "ath_change_percentage":-19.49074,
 "ath_date":"2024-12-17T18:10:38.805Z",
 "atl":2206.43,"atl_change_percentage":410677.95722,
 "atl_date":"2013-07-05T00:00:00.000Z",
 "roi":null,
 "last_updated":"2025-08-01T20:19:32.207Z",
 "sparkline_in_7d":{"price":[116140.32153899151,116519.04909679179]},
 "price_change_percentage_24h_in_currency":-4.250358358149192
 }
*/


struct Coin: Identifiable, Codable {
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
