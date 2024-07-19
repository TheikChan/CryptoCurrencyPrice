//
//  CoinDetailCoordinator.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation
import UIKit

class CoinDetailCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    let coinUuid: String
    
    init(navigationController: UINavigationController, coinUuid: String) {
        self.navigationController = navigationController
        self.coinUuid = coinUuid
    }
    
    func start() {
        let coinDetailVC = StoryboardName.Main.viewController(viewControllerClass: CoinDetailVC.self)
        coinDetailVC.viewModel = CoinDetailViewModelImpl(coordinator: self, coinRepo: CoinRepositoryImpl(coinRemoteService: CoinRemoteServiceImpl(apiClient: APIClient())), coinUuid: coinUuid)
        coinDetailVC.modalPresentationStyle = .popover
        coinDetailVC.modalTransitionStyle = .crossDissolve
        navigationController.present(coinDetailVC, animated: true)
    }
    
    func navigateToCoinWebsite(url: String) {
        if let coinWebsiteURL = URL(string: url), UIApplication.shared.canOpenURL(coinWebsiteURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(coinWebsiteURL, completionHandler: nil)
            } else {
                UIApplication.shared.openURL(coinWebsiteURL)
            }
        }
    }
}
