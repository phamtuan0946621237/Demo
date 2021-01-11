//
//  TrademarkViewController.swift
//  CosmeticsDemo
//
//  Created by admin on 12/31/20.
//

import UIKit
import CardSlider
import SDWebImage
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
    var dataTradeMark : [TradeMarkItem] = []
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
//                    self?.dataTradeMark = (data!["data"] as! [[String : Any]])
//                    print(self!.dataTradeMark)
                    if let tradeMarkArr = data!["data"] as? [[String : Any]] {
                        for obj in tradeMarkArr {
                            let tradeMarkObj = TradeMarkItem()
                            tradeMarkObj.name = obj["name"] as? String
                            tradeMarkObj.icon = obj["images"] as? String
                            tradeMarkObj.idTradeMark = obj["id"] as? Int
                            self!.dataTradeMark.append(tradeMarkObj)
                        }
                        self?.collectionVIew.reloadData()
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
            let item = dataTradeMark[indexPath.row]

        cell.titleTradeMark.setTitle(dataTradeMark[indexPath.row].name, for: .normal) 

        if let imageUrl = dataTradeMark[indexPath.row].icon {
            cell.icon.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        cell.rowIndex = indexPath.row
        cell.setHandle(handle: {(index : Int) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            let categoriesObj = self.dataTradeMark[index]
            vc?.idFilter = categoriesObj.idTradeMark
            vc?.type = "tradeMark"
        })
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello",indexPath.row)

    }
    
    
}
