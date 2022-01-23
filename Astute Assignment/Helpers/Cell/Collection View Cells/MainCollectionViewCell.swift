//
//  MainCollectionViewCell.swift
//  Astute Assignment
//
//  Created by Yasin on 23/01/2022.
//

import UIKit
import SDWebImage
class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemBackgroundimage: UIImageView!
    
    func setData(data: ImagesModel) {
        itemBackgroundimage.isHidden = true
        Utills.shared.addCornerRadiusAndShadowToView(view: backGroundView, cornerRadious: 10, shadowColor: CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.23), shadowOpacity: 6, shadowWidth: 0, shadowHeight: 3)
        itemImage.layer.cornerRadius = 6
        if data.id == "2" || data.id == "6" {
            itemImage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + "upload/images/" + data.cover_image), completed: nil)
        } else {
            itemImage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + data.cover_image), completed: nil)
        }
        titleLabel.text = data.title
    }
    
    func setDataForList(data: ImagesModel) {
        itemBackgroundimage.layer.cornerRadius = 20
        itemBackgroundimage.isHidden = false
        Utills.shared.addCornerRadiusAndShadowToView(view: backGroundView, cornerRadious: 10, shadowColor: CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.23), shadowOpacity: 6, shadowWidth: 0, shadowHeight: 3)
        itemImage.layer.cornerRadius = 6
        if data.id == "2" || data.id == "6" {
            itemImage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + "upload/images/" + data.background_image), completed: nil)
            itemBackgroundimage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + "upload/images/" + data.cover_image), completed: nil)
        } else {
            itemImage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + data.background_image), completed: nil)
            itemBackgroundimage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + data.cover_image), completed: nil)
        }
        titleLabel.text = data.title
    }
    
}
