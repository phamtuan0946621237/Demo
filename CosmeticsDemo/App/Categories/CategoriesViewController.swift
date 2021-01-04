//
//  CategoriesViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 1/1/21.
//

import UIKit

class CategoriesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var hello : [CategoriesItem] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewFeature: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewFeature.layer.cornerRadius = 24
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 24
        tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CategoriesTableViewCell")
        dataAPI()
        // Do any additional setup after loading the view.
    }
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
                            self!.hello.append(categoriesObj)
                        }
                        self?.tableView.reloadData()
                    }
                }
//                print("trademark : ",data!["data"] as! [String : Any])
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hello.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell",for: indexPath) as! CategoriesTableViewCell
        let categoriesObj = hello[indexPath.row]
        cell.name.text = categoriesObj.name
        cell.time.text = categoriesObj.time
        cell.icon.image = UIImage(named: "tuhai.jpg")
//        if let imageUrl = pokemonObj.imageUrl {
//            cell.avatarImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
//        }
        return cell
        
    }
}
