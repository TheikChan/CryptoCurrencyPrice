//
//  InviteFriendCell.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 19/07/2024.
//

import UIKit

protocol InviteFriendCellDelegate: AnyObject {
    func onTapInviteFriend()
}

class InviteFriendCell: UITableViewCell {
    static let identifier: String = "InviteFriendCell"
    
    var delegate: InviteFriendCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
