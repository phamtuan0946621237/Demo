//
//  TrademarkViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 12/31/20.
//

import UIKit
import CardSlider
struct WeatherItem {
    var time : String?
}
//struct Item : CardSliderItem {
//    var image: UIImage
//
//    var rating: Int?
//
//    var title: String
//
//    var subtitle: String?
//
//    var description: String?
//
//}
class TrademarkViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
//   var data = [Item]()
    @IBOutlet weak var collectionVIew: UICollectionView!
    //
//
//    @IBOutlet var myButton : UIButton!
    var data = [
        WeatherItem(time: "3 am"),
        WeatherItem(time: "6 am"),
        WeatherItem(time: "9 am"),
        WeatherItem(time: "12 am"),
        WeatherItem(time: "3 pm"),
        WeatherItem(time: "6 pm"),
        WeatherItem(time: "9 pm"),
    ]
    var dataTradeMark : [[String : Any]] = []
    @IBOutlet weak var banner: UIImageView!
    override func viewDidLoad() {
        collectionVIew.dataSource = self
        collectionVIew.showsHorizontalScrollIndicator = false
//        data.append(Item(image: UIImage(named: "haitu.jpg")!, rating: nil, title: "Book", subtitle: "Get ecccieg", description: "You can add Book"))
//        data.append(Item(image: UIImage(named: "haitu.jpg")!, rating: nil, title: "Book", subtitle: "Get ecccieg", description: "You can add Book"))
//        data.append(Item(image: UIImage(named: "haitu.jpg")!, rating: nil, title: "Book", subtitle: "Get ecccieg", description: "You can add Book"))
        super.viewDidLoad()
        banner.layer.cornerRadius = 24
        dataAPI()
        // Do any additional setup after loading the view.
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        self.view.addSubview(button)
//        myButton.backgroundColor = .link
//        myButton.setTitleColor(.white, for: .normal)
    }
//    @IBAction func didTapButton() {
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

     */
    func dataAPI() {
        let parameters : [String : String]? = nil
        let service = Connect()
        service.fetchGet(endPoint: "trademark",token : nil,parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            switch data?["success"] as! Bool {
            case true :
//                let lll = data?["data"] as! [String : Any]
                print("data : ",data!["data"] as! [[String : Any]] )
                if(data!["data"] != nil) {
                    self?.dataTradeMark = (data!["data"] as! [[String : Any]])
                    print(self!.dataTradeMark)
                    self?.collectionVIew.reloadData()
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
    
}

extension TrademarkViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if dataTradeMark != nil {
            return dataTradeMark.count
//        }
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TradeMarkCollectionViewCell", for: indexPath) as! TradeMarkCollectionViewCell
//        if dataTradeMark != nil {
            let item = dataTradeMark[indexPath.row]
        if (indexPath.row == 1) {
            cell.icon.image = UIImage(named: "tuhai.jpg")
        }
        cell.icon.image = UIImage(named: "cochacyeuladay.jpg")
        cell.titleTradeMark.text = item["name"] as! String
//        }
        return cell
    }
    
}
