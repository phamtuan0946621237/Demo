//
//  ListNotificationTableViewCell.swift
//  CosmeticsDemo
//
//  Created by admin on 1/8/21.
//

import UIKit

//typealias handlSeenNotification = (String) -> ()
class ListNotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var describe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        icon.layer.cornerRadius = 4
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
