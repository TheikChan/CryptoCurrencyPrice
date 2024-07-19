//
//  String.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 19/07/2024.
//

import Foundation
import UIKit

extension String {
    func attributedText(fullText: NSString, highlightString: String, labelFont : UIFont = AppTheme.Font.captionRegularFont,
                        highlightColor: UIColor = .black, highlightFont: UIFont = AppTheme.Font.captionBoldFont) -> NSAttributedString {
        let nonHighlightFontAttribute = [NSAttributedString.Key.font: labelFont]
        
        let changeThemeString = NSMutableAttributedString(string: fullText as String, attributes: nonHighlightFontAttribute)
        
        if !highlightString.isEmpty {
            let boldFontAttribute = [NSAttributedString.Key.font: highlightFont,
                                     NSAttributedString.Key.foregroundColor: highlightColor]
            changeThemeString.addAttributes(boldFontAttribute, range: fullText.range(of: highlightString))
        }
        
        return changeThemeString
    }
}

