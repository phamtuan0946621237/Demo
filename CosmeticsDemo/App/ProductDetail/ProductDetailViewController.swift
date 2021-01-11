//
//  ProductDetailViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 1/4/21.
//

import UIKit
import SDWebImage

class ProductDetailViewController: UIViewController {
    //variable
    @IBOutlet weak var buttonAddProductNumber: UIView!
    @IBOutlet weak var titlePro: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var describe: UILabel!
    @IBOutlet weak var imageDetailProduct: UIImageView!
    @IBOutlet weak var buttonAddToBag: UIButton!
    var idProduct : Int = 0
    let defaults = UserDefaults.standard
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildView()
        getDataDetailProduct(id : idProduct)
    }
    
    //action
    @IBAction func onClickAddToCart(_ sender: Any) {
        let email = self.defaults.string(forKey: "email")
        let concurrentQueue = DispatchQueue(label: "swiftlee.concurrent.queue", attributes: .concurrent)

        concurrentQueue.async { [self] in
            self.addToCartApi(email: email!, productId: idProduct)
        }
        concurrentQueue.async {
            self.addNoticetApi(email: email!)
        }
        
        
    }
}

// view
extension ProductDetailViewController {
    func buildView() {
        buttonAddProductNumber.layer.cornerRadius = 16
        buttonAddToBag.layer.cornerRadius = 24
        imageDetailProduct.layer.cornerRadius = 32
        print("idProduct : ",idProduct)
    }
}

// get Api
extension ProductDetailViewController {
    func getDataDetailProduct(id : Int) {
        let parameters : [String : String]? = nil
        let service = Connect()
        service.fetchGet(endPoint: "product/\(id)",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
                print("data : ",data!["data"] as! [[String : Any]] )
                if(data!["data"] != nil) {
                    let productDetailArr = data!["data"] as! [[String : Any]]
                    let productDetail = productDetailArr[0]
                    self?.titlePro.text = productDetail["name"] as? String
                    self?.price.text = productDetail["price"] as? String
                    self?.describe.text = productDetail["description"] as? String
                    self?.imageDetailProduct.sd_setImage(with: URL(string: productDetail["images"] as! String), completed: nil)
                }
                break;
            case false :
                
                break;
            default :
                 break
            }
    }
}
    
    func addToCartApi(email : String,productId : Int) {
        let parameters : [String : Any]? = ["email" : email,"productId" : productId]
        let service = Connect()
        service.fetchPost(endPoint: "cart/create",token : nil,parram : parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
                
            case true :
                let alert = UIAlertController(title: "Thành công", message: (data?["message"] as! String), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self!.present(alert, animated: true, completion: nil)
                break;
            case false :
                print("login fail")
                let alert = UIAlertController(title: "Không được bạn ơi", message: (data?["message"] as! String), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self!.present(alert, animated: true, completion: nil)
                break;
            default :
                 break
            }
    }

}
    func addNoticetApi(email : String) {
        let parameters : [String : Any]? = ["email" : email,"name" : "Thêm vào giỏ hàng","icon" : "https://img.lovepik.com/element/40019/5457.png_860.png","content" : "Mua hàng đi bạn ơi ","status" : "he_thong","status_read": "no_read"]
        let service = Connect()
        service.fetchPost(endPoint: "create-notification",token : nil,parram : parameters)
        service.completionHandler {
            [weak self] (data) in
            print("create_notification",data)
            switch data?["success"] as! Bool {
                
            case true :
                
//                let alert = UIAlertController(title: "Thành công", message: "Thêm sản phẩm thành công", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//                NSLog("The \"OK\" alert occured.")
//                }))
//                self!.present(alert, animated: true, completion: nil)
                break;
            case false :
                print("login fail")
                let alert = UIAlertController(title: "Không được bạn ơi", message: (data?["message"] as! String), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self!.present(alert, animated: true, completion: nil)
                break;
            default :
                 break
            }
    }

}
    
}


