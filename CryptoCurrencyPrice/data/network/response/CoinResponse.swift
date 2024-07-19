//
//  CoinResponse.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation

struct CoinResponse: Decodable, Hashable {
    
    var uuid: String?
    var symbol: String?
    var name: String?
    var color: String?
    var iconUrl: String?
    var marketCap: String?
    var price: String?
    var change: String?
    var rank: Int?
    
    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color, iconUrl, marketCap, price, change, rank
    }
}

extension CoinResponse {
    var coinChange: CoinChangeType? {
        return CoinChangeType(rawValue: change ?? "")
    }
    
    var formattedPrice: String {
        return CurrencyFormatter.shared.formattedPrice(Double(price ?? "") ?? 0.0, maxDigit: 5, numberStyle: .currency)
    }
}

//{
//    "uuid": "Qwsogvtv82FCd",
//    "symbol": "BTC",
//    "name": "Bitcoin",
//    "color": "#f7931A",
//    "iconUrl": "https://cdn.coinranking.com/Sy33Krudb/btc.svg",
//    "marketCap": "159393904304",
//    "price": "9370.9993109108",
//    "listedAt": 1483228800,
//    "change": "-0.52",
//    "rank": 1,
//    "sparkline": [
//      "9515.0454185372",
//      "9540.1812284677",
//      "9554.2212643043",
//      "9593.571539283",
//    ...
//    ],
//    "coinrankingUrl": "https://coinranking.com/coin/Qwsogvtv82FCd+bitcoin-btc",
//    "24hVolume": "6818750000"
//    "btcPrice": "1",
//    "contractAddresses": []
//}
