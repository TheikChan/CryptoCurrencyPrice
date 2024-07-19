//
//  UIImage.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 19/07/2024.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {    
    func networkImage(url: URL) {
        self.sd_setImage(with: url, placeholderImage: nil, options: [], context: [.imageThumbnailPixelSize : self.bounds.size])
    }
}
