//
//  CoinDetailVC.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import UIKit
import Combine

class CoinDetailVC: UIViewController {

    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinNameLabel: TitleBoldLabel!
    @IBOutlet weak var coinSymbolLabel: TitleLabel!
    @IBOutlet weak var coinPriceLabel: CaptionSmallLabel!
    @IBOutlet weak var coinMarketCaptLabel: CaptionSmallLabel!
    @IBOutlet weak var coinDescriptionTextView: UITextView!
    
    @IBOutlet weak var goToWebsiteButton: UIButton!
    
    var subscriptions = Set<AnyCancellable>()
    var errorView: ErrorView?
    
    var viewModel: CoinDetailViewModelImpl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        loadData()
    }
    
    func loadData() {
        viewModel?.getCoinDetail()
    }
    
    @IBAction func pressClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func displayDetailInfo(coin: CoinDetail) {
        coinNameLabel.text = coin.name
        coinNameLabel.textColor = UIColor(hexString: coin.color ?? "")
        if let coinSymbol = coin.symbol {
            coinSymbolLabel.text =  "(\(coinSymbol))"
        }
        coinPriceLabel.text = coin.detailPrice
        coinMarketCaptLabel.text = coin.detailMarketCapt
        coinDescriptionTextView.text = coin.description
        
        if let coinImageUrl = URL(string: coin.iconUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            coinImage.networkImage(url: coinImageUrl)
        }
    }
    
    @IBAction func pressGoToWebsite(_ sender: Any) {
        viewModel?.navigateToCoinWebsite()
    }
    
    func showErrorView() {
        errorView = ErrorView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 100.0))
        errorView?.delegate = self
        self.view.addSubview(errorView ?? UIView())
    }
    
    func hideErrorView() {
        errorView?.removeFromSuperview()
    }
}

// MARK: ErrorViewDelegate

extension CoinDetailVC: ErrorViewDelegate {
    func onTapTryAgain() {
        loadData()
    }
}

extension CoinDetailVC {
    func bindViewModel() {
        viewModel?.errorSubject.subscribe(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let self else { return }
                
                self.showErrorView()
            }
            .store(in: &subscriptions)

        viewModel?.coinDetailSubject.subscribe(on: DispatchQueue.main)
            .sink { [weak self] response in
                guard let self, let coinDetail = response else { return }
                
                self.hideErrorView()
                self.displayDetailInfo(coin: coinDetail)
            }
            .store(in: &subscriptions)
    }
}
