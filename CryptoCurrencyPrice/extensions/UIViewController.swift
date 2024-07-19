//
//  UIViewController.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func initiate(appStoryBoard: StoryboardName) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
}
