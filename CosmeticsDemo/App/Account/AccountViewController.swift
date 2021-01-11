//
//  AccountViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 12/30/20.
//

import UIKit
import Alamofire

struct UserInfo {
    var name : String
}
class AccountViewController: UIViewController {
    // variable
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    var dataUserInfo : UserInfo?
    let defaults = UserDefaults.standard
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var layoutFeature: UIView!
    @IBOutlet weak var ava: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        buildMainView() // getView
        let email = self.defaults.string(forKey: "email")!
        self.dataAPI(email: email) // get Data
        
    }
    
}

extension AccountViewController {
    func buildMainView() {
        ava.layer.cornerRadius = 90
        layoutFeature.layer.cornerRadius = 36
        buttonEdit.layer.cornerRadius = 30
    }
}

extension AccountViewController {
    
    
    
    func dataAPI(email : String) {
        let parameters : [String : String]? = ["email" : email]
        let service = Connect()
        service.fetchGet(endPoint: "info-user",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
//            print("iiii : ",data)
            switch data?["success"] as! Bool {
            case true :
                if(data!["data"] != nil) {
                    if let productArr = data!["data"] as? [String : Any] {
                        print("qqqqqq : ",productArr)
                        self?.dataUserInfo?.name = productArr["userName"] as! String
                        self?.userName.text = (productArr["userName"] as! String)
                        self?.birthday.text = productArr["date"] as? String
                        self?.phone.text = productArr["phone"] as? String
//                        self?.userName.text = productArr["userName"] as! String
                        
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
