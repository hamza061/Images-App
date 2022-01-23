//
//  ViewController.swift
//  Astute Assignment
//
//  Created by Yasin on 23/01/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if NetworkServices.shared.isConnected {
            AlamofireServices.shared.getAllImages(completion: {err , images in
                if err == nil {
                    print(images!)
                } else {
                    print(err!.lowercased())
                }
            })
            AlamofireServices.shared.getImageDetailsByid(id: "2", completion: {(err,imageDetails) in
                if err == nil {
                    print(imageDetails!.data.id)
                } else {
                    Utills.shared.showAlertWrapper(vc: self, title: "Error", message: err!.localizedCapitalized)
                }
            })
            
            AlamofireServices.shared.getSuggestedImages(id: "3", completion: {(err,images) in
                if err == nil {
                    print(images!)
                } else {
                    print(err!.lowercased())
                }
            })
        } else {
            Utills.shared.showAlertWrapper(vc: self, title: "Error", message: "Please make sure you are connected to internet")
        }
        
    }


}

