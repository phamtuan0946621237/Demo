//
//  ListProducerTableViewCell.swift
//  CosmeticsDemo
//
//  Created by admin on 1/4/21.
//

import UIKit

class ListProducerTableViewCell: UITableViewCell {


    @IBOutlet weak var layoutView: UIView!
    @IBOutlet weak var avaProducer: UIImageView!
    @IBOutlet weak var timeProducer: UILabel!
    @IBOutlet weak var phoneProducer: UILabel!
    @IBOutlet weak var addressProducer: UILabel!
    @IBOutlet weak var nameProducer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutView.layer.cornerRadius = 16
        avaProducer.layer.cornerRadius = 16
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
