//
//  SplashViewController.swift
//  Crossroads of fate
//
//  Created by 丸茂優輝 on 2022/08/21.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let isAgreeTermsOfUse = UserDefaults.standard.bool(forKey: "isAgreeTermsOfUse")
        if isAgreeTermsOfUse {
            DispatchQueue.main.async {
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.pushTitleView), userInfo: nil, repeats: false)
            }
        } else {
            DispatchQueue.main.async {
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.pushTermsOfUseView), userInfo: nil, repeats: false)
            }
            
        }
        
    }
    
    @objc func pushTitleView(){
        let next = self.storyboard!.instantiateViewController(withIdentifier: "Title") as! TitleViewController
        addFadeOutLayer()
        self.navigationController?.pushViewController(next,animated: false)
    }
    
    @objc func pushTermsOfUseView(){
        let next = self.storyboard!.instantiateViewController(withIdentifier: "TermsOfUse") as! TermsOfUseViewController
        addFadeOutLayer()
        self.navigationController?.pushViewController(next,animated: false)
    }
    
}
