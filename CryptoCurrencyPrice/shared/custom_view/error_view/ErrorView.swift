//
//  ErrorView.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 19/07/2024.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func onTapTryAgain()
}

class ErrorView: BaseNibView {
    
    var delegate: ErrorViewDelegate?
    
    override func setupUI() {
        super.setupUI()
    }
    
    @IBAction func tryAgainPress(_ sender: Any) {
        delegate?.onTapTryAgain()
    }
    
}
