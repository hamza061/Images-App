//
//  Utills.swift
//  Astute Assignment
//
//  Created by Yasin on 23/01/2022.
//

import Foundation
import UIKit
class Utills {
    public static let shared = Utills()
    
    public var imageBaseUrl = "https://blogswizards.com/mobile_app_assignment/"
    
    func addCornerRadiusAndShadowToView(view: UIView,cornerRadious: CGFloat,shadowColor: CGColor, shadowOpacity: Float, shadowWidth: Double, shadowHeight: Double) {
        view.layer.cornerRadius = cornerRadious
        view.layer.shadowColor = shadowColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
    }
    
    func showAlertWrapper(vc: UIViewController,title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func roundEdges(view: UIView, cornerRadious: CGFloat, bendCorners: CACornerMask ) {
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadious
        view.layer.maskedCorners = bendCorners
    }
    
}
