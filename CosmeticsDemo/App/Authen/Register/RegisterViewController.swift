//
//  RegisterViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 12/29/20.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputFullName: UITextField!
    @IBOutlet weak var inputGender: UITextField!
    @IBOutlet weak var inputBirthday: UITextField!
    @IBOutlet weak var inputPhone: UITextField!
    let dataGender = ["male","female"]
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    var stateGender = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds.size
        datePicker.frame = CGRect(x: 0, y: 100, width: screenSize.width, height: 100)
        self.hideKeyboardWhenTappedAround()
        buttonRegister.layer.cornerRadius = 24
        inputEmail.layer.cornerRadius = 24
        inputPassword.layer.cornerRadius = 24
        inputFullName.layer.cornerRadius = 24
        inputGender.layer.cornerRadius = 24
        inputBirthday.layer.cornerRadius = 24
        inputPhone.layer.cornerRadius = 24
        pickerView.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self
        createDatePicker()
        createPickGender()
        // Do any additional setup after loading the view.
    }
    func dataAPI(email : String,passwork : String,name : String,phone : String,gender : String,date : String) {
        let parameters : [String : String] = ["email" : email,"password" : passwork,"name" : name, "phone" : phone,"gender" : gender,"date" : date]
        let service = Connect()
        service.fetchPost(endPoint: "auth/register",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
//                print("data",data)
//                let alert = UIAlertController(title: "Login Unsuccess", message: (data?["message"] as! String), preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//                NSLog("The \"OK\" alert occured.")
//                }))
//                self!.present(alert, animated: true, completion: nil)
//    //            print("data",data?["data"] as! [String : String])
//    //            let lll = data?["data"] as! [String : String]
//    ////                vc?.nameAddress = item.name ?? ""
//    ////                vc?.idAddress = item.id
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController // resetRoot navigation
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
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
    // ViewDatePicker
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: false)
        
        inputBirthday.inputAccessoryView = toolbar
        inputBirthday.inputView = datePicker
        
        datePicker.datePickerMode = .date
        
    }
    @objc func donePressed() {
        let myTimeStamp = datePicker.date.timeIntervalSince1970

        inputBirthday.text = "\(myTimeStamp)"
        self.view.endEditing(true)
    }
    // ViewPicker Gender
    func createPickGender() {
        let toolBar = UIToolbar()
        toolBar.tintColor = UIColor.systemBlue
        toolBar.barTintColor = .white
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneGender))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        inputGender.inputView = pickerView
        inputGender.inputAccessoryView = toolBar
        inputGender.textAlignment = .center
    }
    
    @objc func doneGender() {
        inputGender.resignFirstResponder()
        inputGender.text = self.stateGender
//        inputGender.text = "\(pickerView.)"
        self.view.endEditing(true)
    }
    
    // Action
    @IBAction func onClickRegister(_ sender: Any) {
        print(inputEmail.text)
        print(inputPassword.text)
        print(inputFullName.text)
        print(inputGender.text)
        print(inputBirthday.text)
        dataAPI(email: inputEmail.text!,passwork: inputPassword.text!,name: inputFullName.text!,phone: inputPhone.text!,gender: inputGender.text!,date: inputBirthday.text!)
    }
}




// dissmis keyboard
extension RegisterViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// picker
extension RegisterViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataGender.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataGender[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateGender = dataGender[row]
        inputGender.canResignFirstResponder
    }
}
