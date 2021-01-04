//
//  ListProductTableViewCell.swift
//  CosmeticsDemo
//
//  Created by admin on 1/4/21.
//

import UIKit

class ListProductTableViewCell: UITableViewCell {

    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var layoutView: UIView!
    
    let instar : Int = 5
    var star : Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutView.layer.cornerRadius = 16
        icon.layer.cornerRadius = 16
        let starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.distribution = .fillEqually
        starStackView.alignment = .center
        starStackView.spacing = 2
        starStackView.tag = 5007
        var arrImageView = [UIImageView]()
        
        for i in 0..<self.instar{
            let imageView = UIImageView()
            if( i == 0) {
                imageView.tag = 5009
            }
            updateStar(index: i, imageView: imageView,star: self.star)
            starStackView.addArrangedSubview(imageView)
            arrImageView.append(imageView)
        }
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        starView.addSubview(starStackView)
        starStackView.topAnchor.constraint(equalTo: starView.topAnchor,constant: 0).isActive = true
        starStackView.leftAnchor.constraint(equalTo: starView.leftAnchor,constant: 0).isActive = true
        starStackView.widthAnchor.constraint(equalTo: starView.widthAnchor,multiplier: 1).isActive = true
        starStackView.heightAnchor.constraint(equalTo: starView.heightAnchor,multiplier: 1).isActive = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func
//    func _buildStarView(starNumber : Int) -> Int {
//        self.star = starNumber
//        return starNumber
//    }
    
    func updateStar(index : Int,imageView : UIImageView,star : Int) {
        self.star = star
        if(index < star) {
            imageView.image = UIImage(named: "icRateActive.png")
        }else {
            imageView.image = UIImage(named: "icRate.png")
        }
    }
    
}
