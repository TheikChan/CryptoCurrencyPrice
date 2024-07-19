//
//  TopCoinRankView.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 19/07/2024.
//

import UIKit

protocol TopCoinRankViewDelegate: AnyObject {
    func onTapRankCoin(coin: CoinResponse)
}

class TopCoinRankView: BaseNibView {
    static let identifier = "TopCoinRankView"
    
    @IBOutlet weak var titleLabel: TitleBoldLabel!
    @IBOutlet weak var topRankCollectionView: UICollectionView!
    
    weak var delegate: TopCoinRankViewDelegate?
    
    var topRankCoinList: [CoinResponse]? {
        didSet {
            topRankCollectionView.reloadData()
        }
    }
    
    override func setupUI() {
        super.setupUI()
        self.setupTopRankCoinCollectionView()
        
        let topRankCount = 3
        let titleMessage = "Top \(topRankCount) rank crypto"
        self.titleLabel.attributedText = titleMessage.attributedText(fullText: titleMessage as NSString, highlightString: "\(topRankCount)", labelFont: AppTheme.Font.titleBoldFont, highlightColor: AppTheme.ThemeColor.red ?? .red, highlightFont: AppTheme.Font.titleBoldFont)
    }
   
    private func setupTopRankCoinCollectionView() {
        topRankCollectionView.register(UINib(nibName: TopCryptoCoinCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: TopCryptoCoinCollectionCell.identifier)
        if let layout = topRankCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
        topRankCollectionView.delegate = self
        topRankCollectionView.dataSource = self
    }
}

extension TopCoinRankView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topRankCoinList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCryptoCoinCollectionCell.identifier, for: indexPath) as? TopCryptoCoinCollectionCell {
            if let coinItem = self.topRankCoinList?[indexPath.row] {
                cell.displayCoin(coin: coinItem)
            }
            return cell
        }
        return UICollectionViewCell()
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 110, height: 140)
        }
        
        let cellCountPerRow: Int = 3
        let itemsSpacing = flowLayout.minimumInteritemSpacing * CGFloat(cellCountPerRow - 1)
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + itemsSpacing

        let itemWidth = (collectionView.bounds.width - totalSpace) / CGFloat(cellCountPerRow)
        return CGSize(width: floor(itemWidth), height: 140.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tapCoin = self.topRankCoinList?[indexPath.row] {
            delegate?.onTapRankCoin(coin: tapCoin)
        }
    }
}
