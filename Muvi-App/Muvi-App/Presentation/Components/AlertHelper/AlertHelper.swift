//
//  AlertHelper.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 15/04/23.
//

import UIKit

class AlertHelper {
    static let shared = AlertHelper()
    private init() { }
    
    func showGeneralAlert(message: String, navigationController: UINavigationController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: message.description, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            navigationController.present(alert, animated: true, completion: nil)
        }
    }
}
