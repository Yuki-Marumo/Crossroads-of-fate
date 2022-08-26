//
//  TitleViewController.swift
//  Crossroads of fate
//
//  Created by 丸茂優輝 on 2022/04/28.
//

import UIKit
import AVFoundation

class TitleViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    let repository = CoreDataSettingParamsRepository()
    let catVoicePlayer1 = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "cat1", withExtension: "mp3")!)
    let catVoicePlayer2 = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "cat2", withExtension: "mp3")!)
    let catVoicePlayer3 = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "cat3", withExtension: "mp3")!)
    let catVoicePlayer4 = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "cat4", withExtension: "mp3")!)
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: BACK_BUTTON,
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    @IBAction func tapStartButton(_ sender: Any) {
        let isNotShowAgainAction = UserDefaults.standard.bool(forKey: "isNotShowAgainAction")
        if !isNotShowAgainAction {
            let alert = UIAlertController(title: ALERT_TITLE, message: ALERT_MESSAGE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: okAction))
            alert.addAction(UIAlertAction(title: NOT_DISPLAY_AGAIN,
                                          style: .default,
                                          handler: notShowAgainAction))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        } else {
            pushGuideView()
        }
    }
    
    private func okAction(_ action: UIAlertAction) {
        pushGuideView()
    }
    
    private func notShowAgainAction(_ action: UIAlertAction) {
        UserDefaults.standard.set(true, forKey: "isNotShowAgainAction")
        pushGuideView()
    }
    
    private func pushGuideView() {
        if repository.getSettingParams().isVoiceGuide {
            let random = Int.random(in: 0...3)
            if random == 0 {
                catVoicePlayer1.play()
            } else if random == 1 {
                catVoicePlayer2.play()
            } else if random == 2 {
                catVoicePlayer3.play()
            } else {
                catVoicePlayer4.play()
            }
        }
        let next = self.storyboard!.instantiateViewController(withIdentifier: "Guide") as! GuideViewController
        next.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(next,animated: true)
    }
    
    @IBAction func tapSettingsButton(_ sender: Any) {
        let next = self.storyboard!.instantiateViewController(withIdentifier: "Settings") as! SettingsTableViewController
        next.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(next,animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

