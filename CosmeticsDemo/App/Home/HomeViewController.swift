//
//  HomeViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 12/30/20.
//

import UIKit
import SDWebImage

struct FeatureItem {
    var icon : String
    var title : String
}
struct DataTypeItem {
    var icon : String
    var name : String
    var price : String
    var star : Int
}
class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var scrollviewFeature: UICollectionView!
    var product : [ProductItem] = []
    let defaults = UserDefaults.standard
   
    @IBOutlet weak var viewContainerSearch: UIView!
    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var searchView: UIView!
    var data = [
        FeatureItem(icon: "icSpCate.png", title: "Categories"),
        FeatureItem(icon: "icSpDeals.png", title: "Products"),
        FeatureItem(icon: "icSpFaqs.png", title: "Producer"),
        FeatureItem(icon: "icSpGifts.png", title: "Notification"),
        FeatureItem(icon: "icSpKazza.png", title: "Kazza"),
        FeatureItem(icon: "icSpServices.png", title: "Services"),
        FeatureItem(icon: "icSpVip.png", title: "Vip"),
        FeatureItem(icon: "icSpVouchers.png", title: "Vouchers"),
        
    ]
    
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var searchView: UIView!
    override func viewDidLoad() {
            
        super.viewDidLoad()
        let email = self.defaults.string(forKey: "email")
        print("email : ",email!)
        tableView.delegate = self
        tableView.dataSource = self
        viewContainerSearch.layer.cornerRadius = 12
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.systemGray5.cgColor
        searchView.layer.cornerRadius = 12
        imageBanner.layer.cornerRadius = 20
        scrollviewFeature.showsHorizontalScrollIndicator = false
        tableView.register(UINib(nibName: "ListProductTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListProductTableViewCell")
        dataAPI()
//        tableView.
        // Do any additional setup after loading the view.
    }
    func dataAPI() {
        let parameters : [String : String]? = nil
        let service = Connect()
        service.fetchGet(endPoint: "product",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
//                let lll = data?["data"] as! [String : Any]
                print("data : ",data!["data"] as! [[String : Any]] )
                if(data!["data"] != nil) {
                    if let productArr = data!["data"] as? [[String : Any]] {
                        for obj in productArr {
                            let productObj = ProductItem()
                            productObj.name = obj["name"] as? String
                            productObj.price = obj["price"] as? String
                            productObj.icon = obj["images"] as? String
                            productObj.description = obj["description"] as? String
                            productObj.description = obj["description"] as? String
                            productObj.idPro = obj["id"] as? Int
                            productObj.star = obj["star"] as? Int
                            self!.product.append(productObj)
                        }
                        self?.tableView.reloadData()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCollectionViewCell", for: indexPath) as! FeatureCollectionViewCell
        let item = data[indexPath.row]
        cell.icon.image = UIImage(named: item.icon)
        cell.titleFeature.text = item.title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if(indexPath.row == 0) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") as? CategoriesViewController
            self.navigationController?.pushViewController(vc!, animated: true)
//            let item = countries[indexPath.row]
//            vc?.titleParam = item.name ?? ""
        }
        if(indexPath.row == 1) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.type = "home"
        }
        if(indexPath.row == 2) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProducerViewController") as? ProducerViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        if(indexPath.row == 3) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListProductTableViewCell", for: indexPath) as! ListProductTableViewCell
        cell.name.text = product[indexPath.row].name

        cell.price.text = product[indexPath.row].price
        cell.describle.text = product[indexPath.row].description
        if let imageUrl = product[indexPath.row].icon {
            cell.icon.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        cell.setStar(starNumber: product[indexPath.row].star!) // truỳen tham só xuôi
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as?
            ProductDetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.idProduct = product[indexPath.row].idPro!
    }
}
