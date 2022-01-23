//
//  ItemDetailsViewController.swift
//  Astute Assignment
//
//  Created by Yasin on 23/01/2022.
//

import UIKit
import Cosmos
import SDWebImage
import JGProgressHUD
class ItemDetailsViewController: UIViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    var itemId: String = ""
    var comingFrom: String = ""
    var imagesArray: Array<ImagesModel> = []
    let hud = JGProgressHUD(style: .light)
    override func viewDidLoad() {
        super.viewDidLoad()
        designWidgets()
        getData()
        addGesture()
        delegatesAndDataSources()
        
        // Do any additional setup after loading the view.
    }
    
    
    private func designWidgets() {
        Utills.shared.addCornerRadiusAndShadowToView(view: backView, cornerRadious: backView.frame.height/2, shadowColor: CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.23), shadowOpacity: 6, shadowWidth: 0, shadowHeight: 3)
        coverImage.layer.cornerRadius = 20
        Utills.shared.addCornerRadiusAndShadowToView(view: ratingView, cornerRadious: 10, shadowColor: CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.23), shadowOpacity: 6, shadowWidth: 0, shadowHeight: 3)
        Utills.shared.roundEdges(view: descriptionView, cornerRadious: 40, bendCorners: [.layerMinXMinYCorner,.layerMaxXMinYCorner])
    }

    func delegatesAndDataSources() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func getData() {
        self.hud.show(in: self.view)
        AlamofireServices.shared.getImageDetailsByid(id: itemId, completion: {(error,itemDetails) in
            if error == nil {
                if self.itemId == "2" || self.itemId == "6" {
                    self.backGroundImage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + "upload/images/" + itemDetails!.data.background_image), completed: nil)
                    self.coverImage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + "upload/images/" + itemDetails!.data.cover_image), completed: nil)
                } else {
                    self.backGroundImage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + itemDetails!.data.background_image), completed: nil)
                    self.coverImage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + itemDetails!.data.cover_image), completed: nil)
                }
                self.titleLabel.text = itemDetails!.data.title_long
                self.yearLabel.text = itemDetails!.data.year
                self.descriptionText.text = itemDetails!.data.summary
                self.ratingView.text = itemDetails!.data.rating
                self.ratingView.rating = Double(itemDetails!.data.rating) ?? 0
                self.hud.dismiss(animated: true)
            }
        })
        self.hud.show(in: self.view)
        AlamofireServices.shared.getSuggestedImages(id: itemId, completion: {(error, images) in
            if error == nil {
                self.imagesArray.removeAll()
                self.imagesArray.append(contentsOf: images!.data)
                self.collectionView.reloadData()
                self.hud.dismiss(animated: true)
            }
        })
    }

    func addGesture() {
        backView.isUserInteractionEnabled = true
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onListTap(_:))))
    }
    
    @objc func onListTap(_ sender: UITapGestureRecognizer) {
        if comingFrom == "Home" {
            self.dismiss(animated: true, completion: nil)
        } else {
            let vc = AppStoryboard.Main.viewController(viewControllerClass: HomeViewController.self)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}
extension ItemDetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionViewCell", for: indexPath) as! SuggestionCollectionViewCell
        cell.itemImage.layer.cornerRadius = 10
        if self.imagesArray[indexPath.row].id == "2" || self.imagesArray[indexPath.row].id == "6" {
            cell.itemImage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + "upload/images/" + self.imagesArray[indexPath.row].cover_image), completed: nil)
        } else {
            cell.itemImage.sd_setImage(with: URL(string: Utills.shared.imageBaseUrl + self.imagesArray[indexPath.row].cover_image), completed: nil)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AppStoryboard.Main.viewController(viewControllerClass: ItemDetailsViewController.self)
        vc.modalPresentationStyle = .fullScreen
        vc.itemId = imagesArray[indexPath.row].id
        vc.comingFrom = "Details"
        self.present(vc, animated: true, completion: nil)
    }
}
