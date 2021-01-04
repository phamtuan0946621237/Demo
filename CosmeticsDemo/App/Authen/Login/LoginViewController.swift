//
//  LoginViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 12/29/20.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController {
    // variable
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var inputPass: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var Buttonlogin: UIButton!
    @IBOutlet weak var forgot: UIButton!
    let defaults = UserDefaults.standard
    // []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        Buttonlogin.layer.cornerRadius = 24
        inputEmail.layer.cornerRadius = 24
        inputPass.layer.cornerRadius = 24
        
        let parameters : [String : Any]? = nil
//        AF.request("http://localhost:8001/category",method: .get,parameters: parameters).responseJSON(completionHandler: { response in
//            switch response.result {
//            case .success:
//                print("Hello",response.value)
//                break
//            case .failure(_):
//                break
//            default:
//                break
//            }
//        })
    }
    fileprivate let navigationCtrl = UINavigationController()
    // call API
    func dataAPI(email : String,passwork : String) {
        
        let parameters : [String : String] = ["email" : email,"password" : passwork]
        let service = Connect()
        service.fetchPost(endPoint: "auth/login",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            
            case true :
                let lll = data?["data"] as! [String : String]

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                        mainTabBarController.modalPresentationStyle = .fullScreen
                
                self?.present(mainTabBarController, animated: true, completion: nil)
                self!.defaults.set(email,forKey: "email")
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
    // action
    @IBAction func onClickLogin(_ sender: Any) {
        dataAPI(email: inputEmail.text! as String,passwork: inputPass.text! as String)
//        dataAPI(email: "phamtuannd200997@gmail.com",passwork: "0946621237")
    }
    
}

extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


//@IBAction func enter(_ sender: Any) {
//        if textField.text != "" {
//
//        }
//    }
