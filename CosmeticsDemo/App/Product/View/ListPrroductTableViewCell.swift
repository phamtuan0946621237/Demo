//
//  ListPrroductTableViewCell.swift
//  CosmeticsDemo
//
//  Created by admin on 1/4/21.
//

import UIKit

class ListPrroductTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var describe: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var buttonAddNumberProduct: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageContainer.layer.cornerRadius = 24
        buttonAddNumberProduct.layer.cornerRadius = 12
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
