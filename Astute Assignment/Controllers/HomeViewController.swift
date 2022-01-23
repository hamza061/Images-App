//
//  HomeViewController.swift
//  Astute Assignment
// 00 0 00 0 0 00 0 
//  Created by Yasin on 23/01/2022.
//

import UIKit
import JGProgressHUD
class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var listGridConvertionView: UIView!
    @IBOutlet weak var listGridImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    var imagesArray: Array<ImagesModel> = []
    var searchArray: Array<ImagesModel> = []
    var width: Double = 0
    var height: Double = 0
    var isList: Bool = false
    let hud = JGProgressHUD(style: .light)
    override func viewDidLoad() {
        super.viewDidLoad()
        designWedgits()
        getData()
        delegatesAndDataSources()
        addGesture()
        
    }
    
    func designWedgits() {
        Utills.shared.addCornerRadiusAndShadowToView(view: listGridConvertionView, cornerRadious: 8, shadowColor: CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.23), shadowOpacity: 6, shadowWidth: 0, shadowHeight: 3)
        width = 165
        self.height = 200
    }
    
    func delegatesAndDataSources() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    func addGesture() {
        listGridConvertionView.isUserInteractionEnabled = true
        listGridConvertionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onListTap(_:))))
    }
    
    @objc func onListTap(_ sender: UITapGestureRecognizer) {
        if isList {
            UIView.animate(withDuration: 2, animations: {
                self.width = self.collectionView.frame.width / 2
                self.height = 200
                self.listGridImage.image = UIImage(named: "ic_list")
            }) { _ in
                self.collectionView.reloadData()
            }
            isList = false
        } else {
            UIView.animate(withDuration: 2, animations: {
                self.width = (self.collectionView.frame.width)
                self.height = 300
                self.listGridImage.image = UIImage(named: "ic_grid")
            }) { _ in
                self.collectionView.reloadData()
            }
            isList = true
        }
        self.collectionView.reloadData()
    }
    
    
    
    func getData() {
        hud.show(in: self.view)
        if NetworkServices.shared.isConnected {
            AlamofireServices.shared.getAllImages(completion: {(error, images) in
                if error == nil {
                    self.imagesArray.removeAll()
                    self.searchArray.removeAll()
                    self.imagesArray.append(contentsOf: images!.data)
                    self.searchArray.append(contentsOf: images!.data)
                    self.collectionView.reloadData()
                    self.hud.dismiss(animated: true)
                }
            })
        } else {
            self.hud.dismiss(animated: true)
            Utills.shared.showAlertWrapper(vc: self, title: "Alert", message: "You are not connected to internet")
        }
            
        
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        if isList {
            cell.setDataForList(data: imagesArray[indexPath.row])
        } else {
            cell.setData(data: imagesArray[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width - 5, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AppStoryboard.Main.viewController(viewControllerClass: ItemDetailsViewController.self)
        vc.modalPresentationStyle = .fullScreen
        vc.itemId = imagesArray[indexPath.row].id
        vc.comingFrom = "Home"
        self.present(vc, animated: true, completion: nil)
    }
}
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.imagesArray.removeAll()
        if searchText.isEmpty {
            self.imagesArray.append(contentsOf: searchArray)
        } else {
            for item in searchArray {
                if item.title_long.contains(searchText) {
                    self.imagesArray.append(item)
                }
            }
        }
        self.collectionView.reloadData()
        
    }
}
