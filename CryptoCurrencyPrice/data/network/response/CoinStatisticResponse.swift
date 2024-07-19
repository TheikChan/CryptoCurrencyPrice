//
//  CoinStatisticResponse.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation

struct CoinStatisticResponse: Decodable {    
    var total: Int?
    var totalCoins: Int?
    var totalMarkets: Int?
    var totalExchanges: Int?
    var totalMarketCap: String?
    var total24hVolume: String?
}

//{
//  "total": 3,
//  "totalCoins": 10000,
//  "totalMarkets": 35000,
//  "totalExchanges": 300,
//  "totalMarketCap": "239393904304",
//  "total24hVolume": "503104376.06373006"
//}
