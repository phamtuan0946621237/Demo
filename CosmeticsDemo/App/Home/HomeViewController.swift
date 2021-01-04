//
//  HomeViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 12/30/20.
//

import UIKit

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
    let defaults = UserDefaults.standard
    let dataProduct = [
        DataTypeItem(icon: "tuhai.jpg", name: "Son 3ce", price: "300.000 vnd",star: 4),
        DataTypeItem(icon: "tuhai.jpg", name: "Son 3ce", price: "300.000 vnd",star: 5),
        DataTypeItem(icon: "tuhai.jpg", name: "Son 3ce", price: "300.000 vnd",star: 1),
        DataTypeItem(icon: "tuhai.jpg", name: "Son 3ce", price: "300.000 vnd",star: 5),
    ]
    
    @IBOutlet weak var viewContainerSearch: UIView!
    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var searchView: UIView!
    var data = [
        FeatureItem(icon: "icSpCate.png", title: "Categories"),
        FeatureItem(icon: "icSpDeals.png", title: "Deals"),
        FeatureItem(icon: "icSpFaqs.png", title: "Faqs"),
        FeatureItem(icon: "icSpGifts.png", title: "Gifts"),
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
    }
    
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListProductTableViewCell", for: indexPath) as! ListProductTableViewCell
        cell.name.text = dataProduct[indexPath.row].name
        cell.icon.image = UIImage(named: dataProduct[indexPath.row].icon)
        cell.price.text = dataProduct[indexPath.row].price
        cell.star = dataProduct[indexPath.row].star
        return cell
    }
}
