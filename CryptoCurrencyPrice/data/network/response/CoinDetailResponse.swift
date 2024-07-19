//
//  CoinDetailResponse.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation

struct CoinDetailResponse: Decodable {
    
    var status: ResponseStatus?
    var data: CoinDetailResponeData?
    var type: FailedType?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case status, type, message
        case data = "data"
    }
}

struct CoinDetailResponeData: Decodable {
    var coin: CoinDetail?
    
    enum CodingKeys: String, CodingKey {
        case coin = "coin"
    }
}

struct CoinDetail: Decodable {
    var uuid: String?
    var symbol: String?
    var name: String?
    var description: String?
    var color: String?
    var iconUrl: String?
    var websiteUrl: String?
    var marketCap: String?
    var price: String?
    var change: String?
    var rank: Int?
    
    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, description, color, iconUrl, websiteUrl, marketCap, price, change, rank
    }
}

extension CoinDetail {
    var coinChange: CoinChangeType? {
        return CoinChangeType(rawValue: change ?? "")
    }
    
    var detailPrice: String {
        return CurrencyFormatter.shared.formattedPrice(Double(price ?? "") ?? 0.0, maxDigit: 2, numberStyle: .currency)
    }
    
    var detailMarketCapt: String {
        return CurrencyFormatter.shared.calculateCurrencyUnits(from: marketCap ?? "", numberStyle: .currency)
    }
}

//{
//  "status": "success",
//  "data": {
//    "coin": {
//      "uuid": "Qwsogvtv82FCd",
//      "symbol": "BTC",
//      "name": "Bitcoin",
//      "description": "Bitcoin is the first decentralized digital currency.",
//      "color": "#f7931A",
//      "iconUrl": "https://cdn.coinranking.com/Sy33Krudb/btc.svg",
//      "websiteUrl": "https://bitcoin.org",
//      "links": [
//        {
//          "name": "Bitcoin",
//          "url": "https://www.reddit.com/r/Bitcoin/",
//          "type": "reddit"
//        }
//      ],
//      "supply": {
//        "confirmed": true,
//        "supplyAt": 1640757180,
//        "circulating": "17009275",
//        "total": "17009275",
//        "max": "21000000"
//      },
//      "24hVolume": "6818750000",
//      "marketCap": "159393904304",
//      "fullyDilutedMarketCap": "196790985529",
//      "price": "9370.9993109108",
//      "btcPrice": "1",
//      "priceAt": 1640757180,
//      "change": "-0.52",
//      "rank": 1,
//      "numberOfMarkets": 9800,
//      "numberOfExchanges": 190,
//      "sparkline": [
//        "9515.0454185372",
//        "9540.1812284677",
//        "9554.2212643043",
//        "9593.571539283",
//        "9592.8596962985",
//        "9562.5310295967",
//        "9556.7860427046",
//        "9388.823394515",
//        "9335.3004209165",
//        "9329.4331700521",
//        "9370.9993109108"
//      ],
//      "allTimeHigh": {
//        "price": "19500.471361532",
//        "timestamp": 1513555200
//      },
//      "coinrankingUrl": "https://coinranking.com/coin/Qwsogvtv82FCd+bitcoin-btc",
//      "lowVolume": false,
//      "listedAt": 1483228800,
//      "notices": [
//        {
//          "type": "MESSAGE",
//          "value": "Lorem ipsum dolor sit amet"
//        }
//      ],
//      "contractAddresses": [],
//      "tags": [
//        "staking",
//        "layer-1"
//       ]
//    }
//  }
//}
