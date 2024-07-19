//
//  CryptoCoinCell.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import UIKit

class CryptoCoinCell: UITableViewCell {
    static let identifier = "CryptoCoinCell"
    
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var coinTitleLabel: TitleBoldLabel!
    @IBOutlet weak var coinSymbolLabel: CaptionGrayBoldLabel!
    @IBOutlet weak var coinPriceLabel: CaptionSmallBoldLabel!
    @IBOutlet weak var coinChangeLabel: CaptionSmallBoldLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func displayCoin(coin: CoinResponse) {
        coinSymbolLabel.text = coin.symbol
        coinTitleLabel.text = coin.name        
        coinPriceLabel.text = coin.formattedPrice
        coinChangeLabel.text = coin.coinChange?.formattedChangePrice
        coinChangeLabel.textColor = coin.coinChange?.color        
        if let coinImageUrl = URL(string: coin.iconUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            coinImageView.networkImage(url: coinImageUrl)
        }
    }
}
