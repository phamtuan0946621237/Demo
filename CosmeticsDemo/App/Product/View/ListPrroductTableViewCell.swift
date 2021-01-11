//
//  ListPrroductTableViewCell.swift
//  CosmeticsDemo
//
//  Created by admin on 1/4/21.
//

import UIKit

typealias ListProductCellAddToCartHandle = (Int) -> ()
class ListPrroductTableViewCell: UITableViewCell {
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var describe: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var buttonAddNumberProduct: UIView!
    
    @IBOutlet weak var layoutVIew: UIView!
    var addToCart : ListProductCellAddToCartHandle?
    var indexProduct : Int! 
    var isBackground : Bool = false {
        didSet {
            self.layoutVIew.backgroundColor  = isBackground ? .systemGray6 : .white

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageContainer.layer.cornerRadius = 24
        buttonAddNumberProduct.layer.cornerRadius = 12
        icon.layer.cornerRadius = 12
        layoutVIew.backgroundColor  = .white
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAddToCart (handle : @escaping ListProductCellAddToCartHandle) {
        self.addToCart = handle
        
//        self.isBackground =
    }
    
    @IBAction func onClickAddToCart(_ sender: Any) {
        addToCart!(self.indexProduct)
    }
}
