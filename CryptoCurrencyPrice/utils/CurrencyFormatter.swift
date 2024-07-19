//
//  CurrencyFormatter.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation

class CurrencyFormatter {
    
    public static let shared = CurrencyFormatter()
    
    private init() { }
    
    func formattedPrice(_ amount: Double, maxDigit: Int = 2, numberStyle: NumberFormatter.Style = .decimal) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.numberStyle = numberStyle
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        formatter.maximumFractionDigits = maxDigit
        if var formattedPrice = formatter.string(from: NSNumber(value: amount)) {
            if formattedPrice.hasPrefix("-") {
                formattedPrice.removeFirst()
            }
            return formattedPrice
        }else {
            return ""
        }
    }
    
    func calculateCurrencyUnits(from numberString: String, numberStyle: NumberFormatter.Style = .decimal) -> String {
        guard let number = Double(numberString) else {
            return ""
        }

        if number > 1_000_000_000_000 {
            let trillions = number / 1_000_000_000_000
            return "\(formattedPrice(trillions, maxDigit: 2, numberStyle: numberStyle)) trillion"
        }else if number > 1_000_000_000 {
            let trillions = number / 1_000_000_000
            return "\(formattedPrice(trillions, maxDigit: 2, numberStyle: numberStyle)) billion"
        }else if number > 1_000_000 {
            let trillions = number / 1_000_000_000
            return "\(formattedPrice(trillions, maxDigit: 2, numberStyle: numberStyle)) million"
        }else {
            return "\(formattedPrice(number, maxDigit: 2, numberStyle: numberStyle))"
        }
    }
}
