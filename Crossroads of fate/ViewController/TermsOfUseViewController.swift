//
//  TermsOfUseViewController.swift
//  Crossroads of fate
//
//  Created by 丸茂優輝 on 2022/08/21.
//

import UIKit

class TermsOfUseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func agreeButton(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isAgreeTermsOfUse")
        DispatchQueue.main.async {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.pushTitleView), userInfo: nil, repeats: false)
        }
    }
    
    @objc func pushTitleView(){
        let next = self.storyboard!.instantiateViewController(withIdentifier: "Title") as! TitleViewController
        addFadeOutLayer()
        self.navigationController?.pushViewController(next,animated: false)
    }
  
}
