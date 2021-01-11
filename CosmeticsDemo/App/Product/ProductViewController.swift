//
//  ProductViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 1/4/21.
//

import UIKit
import SDWebImage

struct FilterItem {
    var icon : String
    var title : String
}
struct ListProductItem {
    var icon : String
    var name : String
    var price : String
    var describe : String
}

class ProductViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    //variable
    var product : [ProductItem] = []
    let defaults = UserDefaults.standard
    var selectedIndexProduct : Int?
    let dataFilterHor = [
        FilterItem(icon: "icSpCate", title: "Tất cả"),
        FilterItem(icon: "icSpVouchers", title: "Categories"),
        FilterItem(icon: "icSpGifts", title: "Trademark"),
        FilterItem(icon: "icSpServices", title: "Star"),
        FilterItem(icon: "icSpVip", title: "Producer"),
    ]
    var idFilter : Int?
    var type : String?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var layoutSearch: UIView!
    @IBOutlet weak var inputaaa: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
            getView() // view
            callApi() // call Api=
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func onClickSerch(_ sender: Any) {
//        print("hello")
        dataAPI(parameters: ["name" : inputaaa.text!])
//        tableView.reloadData()
        self.product = []
    }
}

// call Api
extension ProductViewController {
    func callApi() {
        switch self.type {
        case "producer":
            print("dung roi",self.idFilter!)
            dataAPI(parameters: ["producerId" : self.idFilter!])
            break;
        case "categories" :
            dataAPI(parameters: ["categoryId" : self.idFilter!])
            break;
        case "tradeMark" :
            break;
        case "home" :
            dataAPI(parameters: nil)
            break;
        default:
            break
        }
    }
}

// buildView
extension ProductViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProductViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListPrroductTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListPrroductTableViewCell")
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
        // view
        layoutSearch.layer.cornerRadius = 16
        tableView.showsVerticalScrollIndicator = false
        headerView.layer.cornerRadius = 32
    }
    
    func buildViewEmpty() -> () {
        let layout = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        var imageView : UIImageView
           imageView  = UIImageView(frame:CGRect(x: 10, y: 100, width: 120, height: 120));
           imageView.image = UIImage(named:"emptyIcon.png")
        imageView.center.x = layout.center.x
        
        let lable = UILabel(frame: CGRect(x: -(self.view.frame.width - 120)/2 + 65, y: 150, width: self.view.frame.width, height: 30))
        
        lable.text = "Không có sản phẩm nào đâu bạn nhớ ! "
        lable.textColor = UIColor.darkGray
        imageView.addSubview(lable)
//        imageView.center.y = layout.center.y
        
        layout.addSubview(imageView)
        tableView.addSubview(layout)
        
        
        
    }
}

// GetDataApi
extension ProductViewController {
    func dataAPI(parameters : [String : Any]?) {
//        let parameters : [String : String]? = nil
        let service = Connect()
        service.fetchGet(endPoint: "product",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
//                print("data : ",data!["data"] as! [[String : Any]] )
                if(data!["data"] != nil) {
                    if let productArr = data!["data"] as? [[String : Any]] {
                        for obj in productArr {
                            let productObj = ProductItem()
                            productObj.name = obj["name"] as? String
                            productObj.price = obj["price"] as? String
                            productObj.icon = obj["images"] as? String
                            productObj.description = obj["description"] as? String
                            productObj.idPro = obj["id"] as? Int
                            self!.product.append(productObj)
                        }
                        // empty data => set viewEmpty
                        if(productArr.count == 0) {
                            self?.buildViewEmpty()
                        }
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
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
//                let connectApiListOrder = OrdersViewController()
//                connectApiListOrder.dataAPI(email: email)
//                connectApiListOrder.listOrder = []
//                OrdersViewController.dataAPI(email : email)
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
// collectionView
extension ProductViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFilterHor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListilterProductCollectionViewCell", for: indexPath) as! ListilterProductCollectionViewCell
        let item = dataFilterHor[indexPath.row]
        cell.icon.image = UIImage(named: item.icon)
        cell.titleFilter.text = item.title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.row)
//        self.getApi()
//        if(indexPath.row == 1) {
//            dataAPI(parameters: nil)
//        }
        }
}
// tableView
extension ProductViewController : UITableViewDelegate,UITableViewDataSource {
    private func reloadSelectedProduct() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPrroductTableViewCell", for: indexPath) as! ListPrroductTableViewCell
        // view
        cell.name.text = product[indexPath.row].name
        if let imageUrl = product[indexPath.row].icon {
            cell.icon.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        cell.price.text = product[indexPath.row].price
        cell.describe.text = product[indexPath.row].description
        cell.indexProduct = indexPath.row
        
        // action
        cell.setAddToCart(handle: { [self](index : Int) in
            // call Api add Cart
            let email = self.defaults.string(forKey: "email")
            addToCartApi(email: email!, productId: self.product[index].idPro!)
            addNoticetApi(email: email!)
            // setIndex
            self.selectedIndexProduct = index
            self.reloadSelectedProduct()
            
        })
        cell.isBackground = self.selectedIndexProduct == indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.idProduct = product[indexPath.row].idPro!
    }
    
    
}
