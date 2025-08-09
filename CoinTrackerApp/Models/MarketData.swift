//
//  MarketData.swift
//  CoinTrackerApp
//
//  Created by Tamerlan Swift on 09.08.2025.
//

import Foundation

// JSON data:
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 18017,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1339,
     "total_market_cap": {
       "btc": 34308518.43724298,
       "eth": 953874669.9073015,
       "ltc": 32217850613.096653,
       "bch": 6865886325.933071,
       "bnb": 4949898969.907797,
       "eos": 7429114068176.478,
       "xrp": 1208773990316.6213,
       "xlm": 8859932164887.818,
       "link": 191398008262.04498,
       "dot": 986489916233.3998,
       "yfi": 703961160.0319484,
       "sol": 22106531823.758133,
       "usd": 4041474870671.3833,
       "aed": 14844337199975.994,
       "ars": 5316085327153851,
       "aud": 6192881271525.621,
       "bdt": 490653029821205.44,
       "bhd": 1523773436388.7146,
       "bmd": 4041474870671.3833,
       "brl": 21972286429379.113,
       "cad": 5559250758352.02,
       "chf": 3266647349941.1367,
       "clp": 3916795370911171,
       "cny": 29034359618390.29,
       "czk": 84804692096220.03,
       "dkk": 25911916133309.58,
       "eur": 3470010323958.4497,
       "gbp": 3004367755259.1763,
       "gel": 10911982150812.736,
       "hkd": 31725375661026.832,
       "huf": 1372404036582588.5,
       "idr": 65698619645121080,
       "ils": 13865067631437.963,
       "inr": 354549497085541.56,
       "jpy": 596744334508864.5,
       "krw": 5612679056142297,
       "kwd": 1234791817236.228,
       "lkr": 1214571287882167,
       "mmk": 8483055753539236,
       "mxn": 75090603097074.3,
       "myr": 17135853451646.668,
       "ngn": 6192711529581055,
       "nok": 41556465357678.484,
       "nzd": 6782706238576.016,
       "php": 229353698910601.03,
       "pkr": 1145901400160977.8,
       "pln": 14742253586217.705,
       "rub": 323302054118295.6,
       "sar": 15168313950033.623,
       "sek": 38712479491187.04,
       "sgd": 5195315946248.064,
       "thb": 130640675194452.48,
       "try": 164377699013830.84,
       "twd": 120868793104656.11,
       "uah": 167056627005129.22,
       "vef": 404672878800.3255,
       "vnd": 105978189981402200,
       "zar": 71762812273814.77,
       "xdr": 2829428474007.295,
       "xag": 105423852324.14966,
       "xau": 1189325224.9411747,
       "bits": 34308518437242.977,
       "sats": 3430851843724297.5
     },
     "total_volume": {
       "btc": 1198684.5228708356,
       "eth": 33326848.714493554,
       "ltc": 1125639947.4295409,
       "bch": 239883039.24405316,
       "bnb": 172941518.7617636,
       "eos": 259561311819.81607,
       "xrp": 42232621513.27662,
       "xlm": 309551797731.0234,
       "link": 6687138957.389914,
       "dot": 34466373029.78065,
       "yfi": 24595272.126834102,
       "sol": 772366711.1991996,
       "usd": 141202639977.20148,
       "aed": 518637296636.26117,
       "ars": 185735481862216.53,
       "aud": 216369323721.54504,
       "bdt": 17142628703777.516,
       "bhd": 53238196161.16419,
       "bmd": 141202639977.20148,
       "brl": 767676392764.0515,
       "cad": 194231291420.6394,
       "chf": 114131411043.4124,
       "clp": 136846538533904.8,
       "cny": 1014413885860.2133,
       "czk": 2962939716225.605,
       "dkk": 905320726213.8275,
       "eur": 121236586684.42519,
       "gbp": 104967783316.81197,
       "gel": 381247127938.4441,
       "hkd": 1108433663689.033,
       "huf": 47949592483458.086,
       "idr": 2295404235733385,
       "ils": 484423190956.58527,
       "inr": 12387389899259.94,
       "jpy": 20849288470298.473,
       "krw": 196097990321138.1,
       "kwd": 43141642592.23438,
       "lkr": 42435169777755.24,
       "mmk": 296384341312146,
       "mxn": 2623545050776.4033,
       "myr": 598699193503.3344,
       "ngn": 216363393210666.1,
       "nok": 1451916145565.5737,
       "nzd": 236976860607.7378,
       "php": 8013249818706.185,
       "pkr": 40035954208326.46,
       "pln": 515070659153.07697,
       "rub": 11295654436166.69,
       "sar": 529956523864.7535,
       "sek": 1352551847813.6172,
       "sgd": 181515993690.69254,
       "thb": 4564375337263.038,
       "try": 5743092756203.363,
       "twd": 4222961474062.162,
       "uah": 5836690196936.011,
       "vef": 14138620340.917181,
       "vnd": 3702707720385618,
       "zar": 2507277384992.776,
       "xdr": 98855685842.75882,
       "xag": 3683340053.098889,
       "xau": 41553112.89249086,
       "bits": 1198684522870.8357,
       "sats": 119868452287083.56
     },
     "market_cap_percentage": {
       "btc": 58.01436175802254,
       "eth": 12.65164931949187,
       "xrp": 4.906362958234454,
       "usdt": 4.070149123344357,
       "bnb": 2.813418615508895,
       "sol": 2.4394296575832373,
       "usdc": 1.617373109191416,
       "steth": 0.9286563451428587,
       "doge": 0.8875437091236859,
       "trx": 0.7897444498882168
     },
     "market_cap_change_percentage_24h_usd": 2.472021897967443,
     "updated_at": 1754734681
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketData?
}

struct MarketData: Codable {
    
//    let totalMarketCap, totalVolume, marketCapPercentage: Dictionary<String, Double>
//    let marketCapChangePercentage24HUsd: Double
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case totalMarketCap = "total_market_cap"
//        case totalVolume = "total_volume"
//        case marketCapPercentage = "market_cap_percentage"
//        //"market_cap_percentage"
//        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
//    }
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
        let marketCapChangePercentage24HUsd: Double
        
        enum CodingKeys: String, CodingKey {
            case totalMarketCap = "total_market_cap"
            case totalVolume = "total_volume"
            case marketCapPercentage = "market_cap_percentage"
            case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        }
    
    var marketCap: String {
        if let value = totalMarketCap["usd"] {
            return "$\(value.asShortenedString())"
        }
        return "и"
    }
    
    var volume: String {
        if let value = totalVolume["usd"] {
            return "$\(value.asShortenedString())"
        }
        return "8"
    }
    var btcDominance: String {
        if let value = marketCapPercentage["btc"] {
            return value.asPercentString()
        }
        return "9"
    }
}
