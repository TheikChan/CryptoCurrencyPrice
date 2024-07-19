//
//  TopCryptoCoinCollectionCell.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import UIKit

class TopCryptoCoinCollectionCell: UICollectionViewCell {
    static let identifier = "TopCryptoCoinCollectionCell"
    
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var coinSymbolLabel: TitleBoldLabel!
    @IBOutlet weak var coinNameLabel: CaptionSmallGrayLabel!
    @IBOutlet weak var coinChangeLabel: CaptionSmallBoldLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displayCoin(coin: CoinResponse) {
        coinSymbolLabel.text = coin.symbol
        coinSymbolLabel.textColor = UIColor(hexString: coin.color ?? "")
        coinNameLabel.text = coin.name
        coinChangeLabel.text = coin.coinChange?.formattedChangePrice
        coinChangeLabel.textColor = coin.coinChange?.color        
        if let coinImageUrl = URL(string: coin.iconUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            coinImageView.networkImage(url: coinImageUrl)
        }
    }
}
