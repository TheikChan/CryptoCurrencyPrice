//
//  CustomLabel.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation
import UIKit

@IBDesignable
class CustomLabel: UILabel {
    
    @IBInspectable var labelColor: UIColor = UIColor.black
    
    #if TARGET_INTERFACE_BUILDER
    override func prepareForInterfaceBuilder() { super.prepareForInterfaceBuilder()
        setup()
    }
    #endif
    
    override init(frame:CGRect) { super.init(frame:frame)
        setup()
    }
    required init?(coder aDecoder:NSCoder) { super.init(coder:aDecoder)
        setup()
    }
    
    func setup() {
        configure(background: UIColor.clear, text: labelColor, font: AppTheme.Font.titleRegularFont)
    }
    
    func configure(background backgroundColor: UIColor, text textColor: UIColor, font: UIFont) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
    }
}

class TitleLabel: CustomLabel {
    override func setup() {
        super.setup()
        font = AppTheme.Font.titleRegularFont
    }
}

class TitleBoldLabel: TitleLabel {
    override func setup() {
        super.setup()
        font = AppTheme.Font.titleBoldFont
    }
}

class TitleGrayLabel: TitleLabel {
    override func setup() {
        super.setup()
        textColor = AppTheme.ThemeColor.gray
    }
}

class CaptionLabel: CustomLabel {
    override func setup() {
        super.setup()
        font = AppTheme.Font.captionRegularFont
    }
}

class CaptionBoldLabel: CaptionLabel {
    override func setup() {
        super.setup()
        font = AppTheme.Font.captionBoldFont
    }
}

class CaptionGrayBoldLabel: CaptionBoldLabel {
    override func setup() {
        super.setup()
        textColor = AppTheme.ThemeColor.gray
    }
}

class CaptionSmallLabel: CustomLabel {
    override func setup() {
        super.setup()
        font = AppTheme.Font.captionSmallRegularFont
    }
}

class CaptionSmallBoldLabel: CaptionSmallLabel {
    override func setup() {
        super.setup()
        font = AppTheme.Font.captionSmallBoldFont
    }
}

class CaptionSmallGrayLabel: CaptionSmallLabel {
    override func setup() {
        super.setup()
        textColor = AppTheme.ThemeColor.gray
    }
}
