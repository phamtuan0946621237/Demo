//
//  ProductDetailViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 1/4/21.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var buttonAddProductNumber: UIView!
//    @IBOutlet weak var buttonAddOrder: UIButton!
    @IBOutlet weak var imageDetailProduct: UIImageView!
    @IBOutlet weak var buttonAddToBag: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAddProductNumber.layer.cornerRadius = 16
        buttonAddToBag.layer.cornerRadius = 24
        imageDetailProduct.layer.cornerRadius = 32
//        buttonAddOrder.layer.cornerRadius = 16
        // Do any additional setup after loading the view.
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
