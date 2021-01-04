//
//  AccountViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 12/30/20.
//

import UIKit
import Alamofire
class AccountViewController: UIViewController {

    let defaults = UserDefaults.standard

    
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var layoutFeature: UIView!
    @IBOutlet weak var ava: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ava.layer.cornerRadius = 90
        layoutFeature.layer.cornerRadius = 36
        buttonEdit.layer.cornerRadius = 30
        let email = self.defaults.string(forKey: "email")
        print("email : ",email)
        dataAPI(email: email!)
//        self.background.view.backgroundColor = UIColor(patternImage: )
        // Do any additional setup after loading the view.
        let parameters : [String : Any] = ["email" : email]
        AF.request("http://localhost:8001/info-user",method: .get,parameters: parameters).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                print("Hello",response.value)
                break
            case .failure(_):
                break
            default:
                break
            }
           
        })
        
    }
    func dataAPI(email : String) {

        let parameters : [String : String] = ["email" : email]
        let service = Connect()
        service.fetchGet(endPoint: "info-user",token : nil,parram :parameters)
//        service.completionHandler {
//            [weak self] (data) in
//            print("hello",data)
//            switch data?["success"] as! Bool {
//
//            case true :
//////                let lll = data!["data"] as! [String : Any]
////                if(lll != nil) {
////
////                    print("data",lll)
////                }else if (lll == nil) {
////                    print("khong dc roi ban oi")
////                }
////
//
////                print("data",data?["success"])
//
////                print("dataUser",lll)
//                break;
//            case false :
//
//                break;
//            default :
//                 break
//            }
//    }

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
