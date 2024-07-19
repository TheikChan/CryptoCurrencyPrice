//
//  CoinChangeType.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation
import UIKit

enum CoinChangeType {
    
    case up(price: String)
    case down(price: String)
    
    init?(rawValue: String) {
        if round(Double(rawValue) ?? 0.0) < 0 {
            self = .down(price: rawValue)
        }else {
            self = .up(price: rawValue)
        }
    }
}

extension CoinChangeType {
    
    var symbol: String {
        switch self {
        case .up:
            return "↑"
        case .down:
            return "↓"
        }
    }
    
    var color: UIColor {
        switch self {
        case .up:
            return AppTheme.ThemeColor.green ?? .green
        case .down:
            return AppTheme.ThemeColor.red ?? .red
        }
    }
    
    /// if coin.change has 0 or more give display character and arrow-up with green color.
    /// if coin.change less than 0 give display character and arrow-down with red color
    var formattedChangePrice: String {
        switch self {
        case .up(let price):
            return "\(self.symbol) \(CurrencyFormatter.shared.formattedPrice(Double(price) ?? 0.0))"
        case .down(let price):
            return "\(self.symbol) \(CurrencyFormatter.shared.formattedPrice(Double(price) ?? 0.0))"
        }
    }
}
