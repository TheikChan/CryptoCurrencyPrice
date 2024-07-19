//
//  StoryboardName.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation
import UIKit

enum StoryboardName: String{
    case Main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    // MARK: - Viewcontroller instantiate
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func navigateController<T: UINavigationController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UINavigationController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
}

