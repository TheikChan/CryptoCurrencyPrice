//
//  BaseNibView.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation
import UIKit

public protocol NibView {
    var nibFileName: String { get }
}

extension NibView where Self: UIView {
    func registerNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(nibFileName, owner: self, options: nil)?.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        } else {
            fatalError("""
                Couldn't find Your Custom view for \(String(describing: self)),
                make sure the view is invalid nib name
                """)
        }
    }
}

open class BaseNibView: UIView, NibView {
    public var nibFileName: String { type(of: self).description().components(separatedBy: ".").last ?? "" }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        registerNib()
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerNib()
        setupUI()
    }
    
    func setupUI() { }
}
