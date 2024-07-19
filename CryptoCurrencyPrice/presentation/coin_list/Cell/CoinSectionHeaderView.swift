//
//  CoinSectionHeaderView.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import UIKit

class CoinSectionHeaderView: UITableViewHeaderFooterView {
    static let identifier: String = "CoinSectionHeaderView"
    
    @IBOutlet weak var titleLabel: TitleBoldLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
