//
//  NotificationViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 1/8/21.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    let defaults = UserDefaults.standard
    var listNotificationData : [ListNotificationItem] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        let email = self.defaults.string(forKey: "email")
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListNotificationTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListNotificationTableViewCell")
        dataAPI(email: email!)  // -> get Data
    }

    @IBAction func onClickSetting(_ sender: Any) {
        print("jelfekwn")
    }
}
extension NotificationViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListNotificationTableViewCell" , for: indexPath) as! ListNotificationTableViewCell
        let item = listNotificationData[indexPath.row]
        // set Value
        cell.name.text = item.name
        cell.describe.text = item.content
        if(item.status == "khuyen_mai") {
            cell.price.text =  "Khuyến mãi"
        }else {
            cell.price.text =  "Hê thống"
        }
        
        if let imageUrl = item.icon {
            cell.icon.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        // set Cell View
        if(item.status_read == "readed"){
            cell.describe.textColor = UIColor.gray
            cell.name.textColor = UIColor.gray
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let email = self.defaults.string(forKey: "email")
        updateStatusSeenNotification(email: email!, noticeId: listNotificationData[indexPath.row].noticeId!)
    }
}

// fetch API
extension NotificationViewController {
    func dataAPI(email : String) {
        let service = Connect()
        service.fetchGet(endPoint: "notification",token : nil,parram :["email" : email] as [String : String]?)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
                if(data!["data"] != nil) {
                    self!.ParseHandlerAPI(data: (data!["data"] as? [[String : Any]])!)
                }
                break;
            case false :
                
                break;
            default :
                 break
            }
    }
}
    
    private func ParseHandlerAPI(data : [[String : Any]] ) {
        if let listNotificationArr = data as?  [[String : Any]]{
            for obj in listNotificationArr {
                let listNotificationObj = ListNotificationItem()
                listNotificationObj.name = obj["name"] as? String
                listNotificationObj.content = obj["content"] as? String
                listNotificationObj.icon = obj["icon"] as? String
                listNotificationObj.noticeId = obj["id"] as? Int
                listNotificationObj.status = obj["status"] as? String
                listNotificationObj.status_read = obj["status_read"] as? String
                self.listNotificationData.append(listNotificationObj)
            }
            self.tableView.reloadData()
        }
    }
    
    func updateStatusSeenNotification(email : String,noticeId : Int) {
        let parameters : [String : Any] = ["email" : email,"noticeId" : noticeId]
        let service = Connect()
        service.fetchPost(endPoint: "update-notification",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            
            case true :
                self?.listNotificationData = []
                self!.dataAPI(email : email)
                break;
            case false :
                print("login fail")
                let alert = UIAlertController(title: "Login Unsuccess", message: (data?["message"] as! String), preferredStyle: .alert)
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
