//
//  UIViewController+Extensions.swift
//  PhotonTest
//
//  Created by Navyasree Janjirala on 7/26/22.
//

import UIKit


extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
