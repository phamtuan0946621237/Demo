//
//  ListOrderTableViewCell.swift
//  CosmeticsDemo
//
//  Created by admin on 1/5/21.
//

import UIKit

typealias ListOrderCellPlusHandle = (Int, Int) -> ()
typealias ListOrderCellMinusHandle = (Int, Int) -> ()

class ListOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var describle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageList: UIImageView!
    @IBOutlet weak var layoutList: UIView!
    @IBOutlet weak var numberProduct: UILabel!
    
    var plusHandle : ListOrderCellPlusHandle?
    var minusHandle : ListOrderCellPlusHandle?
    var rowIndex : Int!
    var number : Int!
//    @IBOutlet weak var imageList: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageList.layer.cornerRadius = 16
        layoutList.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setPlusHandle(handle : @escaping ListOrderCellPlusHandle) {
        self.plusHandle = handle
    }
    func setMinusHandle(handle : @escaping ListOrderCellMinusHandle)  {
        self.minusHandle = handle
    }
    
    @IBAction func onClickSumNumberProduct(_ sender: Any) {
        
        self.number = Int(numberProduct.text!)
//        self.number += 1
//        print("number : ",self.number!)
        plusHandle?(self.number, self.rowIndex)
    }
    @IBAction func onClickDecreaseNumberProduct(_ sender: Any) {
//        if(Int(numberProduct.text!) == 1) {
            self.number = Int(numberProduct.text!)
//        }else {
//            self.number = Int(numberProduct.text!)
//            self.number -= 1
//        }
        minusHandle?(self.number, self.rowIndex)
    }
    
}
