//
//  OrdersViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 1/5/21.
//

import UIKit
import Alamofire
struct OrderItem {
    var icon : String
    var name : String
    var price : String
    var describle : String
    var numberProduct : String
}
class OrdersViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    // variable
    @IBOutlet weak var totalPriceProduct: UILabel!
    var totalP : Float = 0
    var listOrder : [ListOrderItem] = []
    var hellooo : String = "1"
    var index : Int!
    let defaults = UserDefaults.standard
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonCheckOut: UIButton!
    @IBOutlet weak var border: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let email = self.defaults.string(forKey: "email")
        self.dataAPI(email: email!) // getAPI
        buildMainView() // getview
    }
}


// action
extension OrdersViewController {
    @IBAction func onClickDeleteAll(_ sender: Any) {
        let indexPath = IndexPath(item: 0, section: 0)
        self.listOrder.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

// view
extension OrdersViewController {
    func buildMainView() {
        border.layer.borderWidth = 1
        border.layer.borderColor = UIColor.systemGray5.cgColor
        buttonCheckOut.layer.cornerRadius = 16
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ListOrderTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListOrderTableViewCell")
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
        layout.addSubview(imageView)
        tableView.addSubview(layout)
    }
}
    
// tableview
extension OrdersViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOrderTableViewCell", for: indexPath) as! ListOrderTableViewCell
        cell.name.text = listOrder[indexPath.row].name
        
        cell.describle.text = listOrder[indexPath.row].description
        if let imageUrl = listOrder[indexPath.row].icon {
            cell.imageList.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        cell.numberProduct.text = String(listOrder[indexPath.row].quantity!)
        let totalPrice = Float(listOrder[indexPath.row].price!)! * Float(listOrder[indexPath.row].quantity!)
        cell.price.text = String(totalPrice)
        cell.rowIndex = indexPath.row
        
        let emailStorage = self.defaults.string(forKey: "email")
        
        //action
        cell.setPlusHandle(handle: { [self](number : Int, index : Int) in
            cell.numberProduct.text = String(number)
            cell.price.text = String(Float(listOrder[indexPath.row].price!)! * Float(number))
            self.addToCartApi(email: emailStorage!, productId: listOrder[index].productId!)
            self.totalP = 0
        })
        cell.setMinusHandle(handle: { [self](number : Int, index : Int) in
            cell.numberProduct.text = String(number)
            self.removeToCartApi(email: emailStorage!, productId: listOrder[index].productId!)
            self.totalP = 0
        })
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row

    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [self]
            (action,view,complettion) in
            self.listOrder.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            complettion(true)
            self.listOrder.count == 0 ? self.buildViewEmpty() : nil
            
        }
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }

}

// get Data
extension OrdersViewController {
    //get list order
    func dataAPI(email : String) {
        
        print("goi lai ham")
        let parameters : [String : Any]? = ["email" : email]
        let service = Connect()
        service.fetchGet(endPoint: "cart",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
                if(data!["data"] != nil) {
                    if let productArr = data!["data"] as? [[String : Any]] {
                        print("productArr",productArr)
                        for i in 0..<productArr.count{
                            let a = productArr[i] as! [String : Any]
                            let price = a["price"] as! String
                            let number = a["quantity"] as! Int
                            let totalPriceItem = Float(price)! * Float(number)
                            self?.totalP += totalPriceItem
                            self?.totalPriceProduct.text = String(self!.totalP)
//                            print("aaaaaa",totalPriceItem)
                        }
                        for obj in productArr {
                            let listOrderObj = ListOrderItem()
                            listOrderObj.name = obj["name"] as? String
                            listOrderObj.price = obj["price"] as? String
                            listOrderObj.icon = obj["images"] as? String
                            listOrderObj.description = obj["description"] as? String
                            listOrderObj.productId = obj["id"] as? Int
                            listOrderObj.quantity = obj["quantity"] as? Int
                            self!.listOrder.append(listOrderObj)
//                            let a : Float = Float(obj["price"])
//                            print("obj: ",a)
//                            self?.totalP = self?.totalP + Float(obj["price"]) as Float
//                            self!.totalPriceProduct.text = String(self!.totalP)
                            
                        }
                        
                        // empty data => set viewEmpty
                        if(productArr.count == 0) {
                            self?.buildViewEmpty()
                        }
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
//                        for i in 0..<productArr.count-1{
//                            let a = productArr["price"] as! String
//                            print("oooo : ",a)
//                        }
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
    
    
    //addToCartApi
    func addToCartApi(email : String,productId : Int) {
        let parameters : [String : Any]? = ["email" : email,"productId" : productId]
        let service = Connect()
        service.fetchPost(endPoint: "cart/create",token : nil,parram : parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
                self?.dataAPI(email: email)
                self!.listOrder = []
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
    func removeToCartApi(email : String,productId : Int) {
        let parameters : [String : Any]? = ["email" : email,"productId" : productId]
        let service = Connect()
        service.fetchPost(endPoint: "cart/delete",token : nil,parram : parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
                self!.listOrder = []
                self!.dataAPI(email: email)
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
