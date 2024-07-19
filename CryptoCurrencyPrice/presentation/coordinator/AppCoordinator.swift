//
//  AppCoordinator.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController : UINavigationController { get set }
    func start()
}

class AppCoordinator : Coordinator {
    
    var navigationController: UINavigationController

    private var window: UIWindow
    
    //MARK: Initializer
    init(window: UIWindow) {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        self.navigationController = window.rootViewController as! UINavigationController
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func start() {
        navigateToCoinList()
    }
    
    func navigateToCoinList() {
        let coordinator = CoinListCoordinator.init(navigationController: navigationController)
        coordinator.start()
    }
}
