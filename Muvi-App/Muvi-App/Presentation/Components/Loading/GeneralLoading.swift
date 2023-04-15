//
//  GeneralLoading.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 15/04/23.
//

import UIKit

class GeneralLoading {
    static let shared = GeneralLoading()
    
    private init() { }
    
    func showLoading(getNavigation: UINavigationController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            getNavigation.present(alert, animated: true, completion: nil)
        }
    }
    
    func hideLoading(getNavigation: UINavigationController) {
        DispatchQueue.main.async {
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.stopAnimating()
            getNavigation.dismiss(animated: false)
        }
    }
}
