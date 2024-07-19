//
//  AppTheme.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 19/07/2024.
//

import Foundation
import UIKit

struct AppTheme {
    struct Font {
        static let titleRegularFont = UIFont.systemFont(ofSize: 16.0)
        static let captionRegularFont = UIFont.systemFont(ofSize: 14.0)
        static let captionSmallRegularFont = UIFont.systemFont(ofSize: 12.0)
        
        static let titleBoldFont = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        static let captionBoldFont = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        static let captionSmallBoldFont = UIFont.systemFont(ofSize: 12.0, weight: .bold)        
    }
    
    struct ThemeColor {
        static let red = UIColor(named: "redColor")
        static let green = UIColor(named: "greenColor")
        static let gray = UIColor(named: "grayColor")
        static let darkGray = UIColor(named: "darkGrayColor")
        static let highlight = UIColor(named: "highlightColor")
        static let cardBackground = UIColor(named: "cardBackgroundColor")
    }
}
