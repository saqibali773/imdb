//
//  UIViewController.swift
//  museum
//
//  Created by Saqib Ali on 27/02/2022.
//

import Foundation
import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addBackButton(){
        let menuButton = UIBarButtonItem(
            image: UIImage(imageLiteralResourceName: "nav-back"),
            style: .plain,
            target: self,
            action: #selector(backButtonAction))
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    @objc func backButtonAction(){
        self.navigationController?.popViewController(animated: true);
    }
}
