//
//  SearchToolbar.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class SearchToolbar: UIView {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var borderActiveView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(String(describing: SearchToolbar.self), owner: self, options: nil)?.first as! UIView

        self.addSubview(view)
        setupTextField()
    }
    
    private func setupTextField() {
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)]
        )
    }
    
    func setActiveTF() {
        borderActiveView.backgroundColor = UIColor(red: 1, green: 0.82, blue: 0.188, alpha: 1)
    }
    
    func setInactiveTF() {
        borderActiveView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
    }
    
}
