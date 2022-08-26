//
//  CustomUIView.swift
//  Crossroads of fate
//
//  Created by 丸茂優輝 on 2022/05/03.
//

import UIKit

class SubGuideView: UIView {

    @IBInspectable var borderWidth: CGFloat = 2.0
    @IBInspectable var borderColor: CGColor = UIColor.black.cgColor
    @IBInspectable var cornerRadius: CGFloat = 5.0
    @IBInspectable var masksToBounds: Bool = true
    
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = masksToBounds
    }

}
