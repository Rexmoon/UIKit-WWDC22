//
//  ReusableTableViewCell.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/28/23.
//

import UIKit

final class ReusableTableViewCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
