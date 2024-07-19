//
//  UITableView.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation
import UIKit

extension UITableView {
    
    func setEmptyMessage() {
        let emptyBackgroundView = UIView()
        emptyBackgroundView.addSubview(EmptyContentView.init(frame: CGRect.init(x: 0, y: self.bounds.size.height / 2 - 80, width: self.bounds.size.width, height: 80)))
        self.backgroundView = emptyBackgroundView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
    
    func setupTableView(_ cellNibName: String, noFooter: Bool = true){
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.separatorStyle = .none
        self.estimatedRowHeight = 82.0
        self.rowHeight = UITableView.automaticDimension
        self.showsVerticalScrollIndicator = false
        self.isPagingEnabled = true
        if noFooter {
            self.tableFooterView = UIView()
        }
        self.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellNibName)
    }
}
