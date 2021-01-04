//
//  ProductViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 1/4/21.
//

import UIKit

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
    @IBOutlet weak var tableView: UITableView!
    let dataFilterHor = [
        FilterItem(icon: "icSpCate", title: "Tất cả"),
        FilterItem(icon: "icSpVouchers", title: "Categories"),
        FilterItem(icon: "icSpGifts", title: "Trademark"),
        FilterItem(icon: "icSpServices", title: "Boy"),
        FilterItem(icon: "icSpVip", title: "Girl"),
        
    ]
    let dataListProduct = [
        ListProductItem(icon: "tuhai.jpg", name: "Apple Juice", price: "$12.65", describe: "The latest mechanical and optical technology delivers full-frame performance in the world's lightest and most compact2 standard zoom "),
        ListProductItem(icon: "tuhai.jpg", name: "Apple Juice", price: "$12.65", describe: "The latest mechanical and optical technology delivers full-frame performance in the world's lightest and most compact2 standard zoom "),
        ListProductItem(icon: "tuhai.jpg", name: "Apple Juice", price: "$12.65", describe: "The latest mechanical and optical technology delivers full-frame performance in the world's lightest and most compact2 standard zoom "),
        ListProductItem(icon: "tuhai.jpg", name: "Apple Juice", price: "$12.65", describe: "The latest mechanical and optical technology delivers full-frame performance in the world's lightest and most compact2 standard zoom "),
        ListProductItem(icon: "tuhai.jpg", name: "Apple Juice", price: "$12.65", describe: "The latest mechanical and optical technology delivers full-frame performance in the world's lightest and most compact2 standard zoom "),
    ]
    
    @IBOutlet weak var scrollviewHorfilter: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
        tableView.showsVerticalScrollIndicator = false
        headerView.layer.cornerRadius = 32
        searchView.layer.cornerRadius = 16
        scrollviewHorfilter.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListPrroductTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListPrroductTableViewCell")
    }
}


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
        print(indexPath.row)
            
        }
}

extension ProductViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataListProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPrroductTableViewCell", for: indexPath) as! ListPrroductTableViewCell
        cell.name.text = dataListProduct[indexPath.row].name
        cell.icon.image = UIImage(named: dataListProduct[indexPath.row].icon)
        cell.price.text = dataListProduct[indexPath.row].price
        cell.describe.text = dataListProduct[indexPath.row].describe
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
