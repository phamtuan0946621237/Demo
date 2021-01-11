//
//  TradeMarkCollectionViewCell.swift
//  CosmeticsDemo
//
//  Created by admin on 12/31/20.
//

import UIKit

typealias ButtonHande = (Int) -> ()

class TradeMarkCollectionViewCell: UICollectionViewCell {
    var rowIndex : Int!
    var onClick : ButtonHande?
    @IBOutlet weak var titleTradeMark: UIButton!
    //    @IBOutlet weak var titleTradeMark: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var layoutTradeMark: UIView!
    override func awakeFromNib() {
        layoutTradeMark.layer.cornerRadius = 16
        icon.layer.cornerRadius = 16
    }
    
    func setHandle(handle : @escaping ButtonHande) {
        self.onClick = handle
    }
    @IBAction func onClickProduct(_ sender: Any) {
        onClick?(self.rowIndex)
    }
    
}
