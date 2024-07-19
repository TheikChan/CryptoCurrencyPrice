//
//  CircleView.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation
import UIKit

class CircleView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
   }
}
