//
//  CategoriesTableViewCell.swift
//  CosmeticsDemo
//
//  Created by admin on 1/1/21.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var layoutView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutView.layer.cornerRadius = 16
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
