//
//  UIViewController+Extension.swift
//  Crossroads of fate
//
//  Created by 丸茂優輝 on 2022/08/21.
//

import UIKit

extension UIViewController {
    func addFadeOutLayer() {
        // フェードアウト
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        self.view.window?.layer.add(transition, forKey: kCATransition)
    }
}
