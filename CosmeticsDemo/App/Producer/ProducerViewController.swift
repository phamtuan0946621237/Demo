//
//  ProducerViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 1/4/21.
//

import UIKit

class ProducerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var producer : [ProducerItem] = []
//    @IBOutlet weak var buttonEditProducer: UIButton!
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var buttonCreateProducer: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        buttonEditProducer.layer.cornerRadius = 16
//        buttonCreateProducer.layer.cornerRadius = 16
//        buttonEditProducer.layer.borderWidth = 1
//        buttonCreateProducer.layer.borderWidth = 1
//        buttonCreateProducer.layer.borderColor = UIColor.systemGray.cgColor
//        buttonEditProducer.layer.borderColor = UIColor.systemGray.cgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListProducerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListProducerTableViewCell")
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
        dataAPI()
        // Do any additional setup after loading the view.
    }
    
    func dataAPI() {
        let parameters : [String : String]? = nil
        let service = Connect()
        service.fetchGet(endPoint: "producer",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
//                let lll = data?["data"] as! [String : Any]
                print("data : ",data!["data"] as! [[String : Any]] )
                if(data!["data"] != nil) {
                    if let producerArr = data!["data"] as? [[String : Any]] {
                        for obj in producerArr {
                            let producerObj = ProducerItem()
                            producerObj.name = obj["name"] as? String
//                            categoriesObj.icon = "haitu.jpg"
                            producerObj.time = obj["created_at"] as? String
                            producerObj.address = obj["address"] as? String
                            producerObj.ava = obj["avatar"] as? String
                            producerObj.phone = obj["phone"] as? String
                            self!.producer.append(producerObj)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return producer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListProducerTableViewCell", for: indexPath) as! ListProducerTableViewCell
        let producerObj = producer[indexPath.row]
        cell.nameProducer.text = producerObj.name
        cell.timeProducer.text = producerObj.time
        cell.phoneProducer.text = producerObj.phone
        cell.addressProducer.text = producerObj.address
        cell.avaProducer.image = UIImage(named: "aaa.jpg")
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
