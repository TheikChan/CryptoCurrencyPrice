//
//  CoinListCoordinator.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation
import UIKit

class CoinListCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let coinListVC = StoryboardName.Main.viewController(viewControllerClass: CoinListVC.self)
        coinListVC.viewModel = CoinListViewModelImpl(coordinator: self, coinRepo: CoinRepositoryImpl(coinRemoteService: CoinRemoteServiceImpl(apiClient: APIClient())))
        navigationController.setViewControllers([coinListVC], animated: true)
    }
    
    func navigateToCoinDetail(coinUuid: String) {
        let coordinator = CoinDetailCoordinator(navigationController: self.navigationController, coinUuid: coinUuid)
        coordinator.start()
    }
}
