//
//  UIColor.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 19/07/2024.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexString: String, defaultColor: UIColor = .black) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if cString.hasPrefix("0XFF") {
            cString = cString.replacingOccurrences(of: "0XFF", with: "")
        }
        
        /// Handle 6 characters hex color string
        if ((cString.count) == 6) {
            let scanner = Scanner(string: cString)
            var rgbValue: UInt64 = 0
            if scanner.scanHexInt64(&rgbValue) {
                let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
                let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255
                let b = CGFloat(rgbValue & 0x0000FF) / 255
                self.init(red: r, green: g, blue: b, alpha: 1.0)
                return
            }
        }
        /// Handle 8 characters hex color string
        if cString.count == 8 {
            let scanner = Scanner(string: cString)
            var rgbValue: UInt64 = 0
            if scanner.scanHexInt64(&rgbValue) {
                let r = CGFloat((rgbValue & 0xff000000) >> 24) / 255
                let g = CGFloat((rgbValue & 0x00ff0000) >> 16) / 255
                let b = CGFloat((rgbValue & 0x0000ff00) >> 8) / 255
                let a = CGFloat(rgbValue & 0x000000ff) / 255
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        /// Handle default color
        self.init(cgColor: defaultColor.cgColor)
    }
}
