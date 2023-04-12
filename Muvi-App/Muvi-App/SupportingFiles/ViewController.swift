//
//  ViewController.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 12/04/23.
//

import UIKit

class ViewController: UIViewController {
    lazy var lblName: UILabel = {
        var lblName = UILabel()
        lblName.text = "Hello World"
        lblName.textColor = .systemPink
        lblName.font = .systemFont(ofSize: 24, weight: .bold)
        return lblName
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lblName)
        setupConstraint()
    }
    
    private func setupConstraint() {
        lblName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}

