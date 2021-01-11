//
//  CategoriesViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 1/1/21.
//

import UIKit

class CategoriesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    // variable
    var categoriesData : [CategoriesItem] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewFeature: UIView!
    
    // lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        dataAPI()
    }
    
    // view
    func buildView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CategoriesTableViewCell")
        viewFeature.layer.cornerRadius = 24
        tableView.layer.cornerRadius = 24
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
    }
}

// TableView
extension CategoriesViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell",for: indexPath) as! CategoriesTableViewCell
        let categoriesObj = categoriesData[indexPath.row]
        cell.name.text = categoriesObj.name
        cell.time.text = categoriesObj.time
//        cell.icon.image = UIImage(named: "tuhai.jpg")
        if let imageUrl =  categoriesObj.icon {
            cell.icon.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        let categoriesObj = categoriesData[indexPath.row]
        vc?.idFilter = categoriesObj.idCategory
        vc?.type = "categories"
    }
}

// fetch API
extension CategoriesViewController {
    func dataAPI() {
        let parameters : [String : String]? = nil
        let service = Connect()
        service.fetchGet(endPoint: "category",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
//                let lll = data?["data"] as! [String : Any]
                print("data : ",data!["data"] as! [[String : Any]] )
                if(data!["data"] != nil) {
                    if let categoriesArr = data!["data"] as? [[String : Any]] {
                        for obj in categoriesArr {
                            let categoriesObj = CategoriesItem()
                            categoriesObj.name = obj["name"] as? String
//                            categoriesObj.icon = "haitu.jpg"
                            categoriesObj.time = obj["created_at"] as? String
                            categoriesObj.icon = obj["images"] as? String
                            categoriesObj.idCategory = obj["id"] as? Int
                            self!.categoriesData.append(categoriesObj)
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
}
