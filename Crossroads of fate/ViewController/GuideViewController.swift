//
//  GuideViewController.swift
//  Crossroads of fate
//
//  Created by 丸茂優輝 on 2022/05/03.
//

import UIKit
import AVFoundation

class GuideViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var mainCatImage: UIImageView!
    @IBOutlet weak var subMessage: UILabel!
    @IBOutlet weak var subCatImage: UIImageView!
    
    @IBOutlet weak var nyaLabel: UILabel!
    @IBOutlet weak var subGuideView: SubGuideView!
    
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    let queue = DispatchQueue.global(qos: .default)
    var isEnabled = false
    
    let countPlayer = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "count", withExtension: "mp3")!)
    let completedPlayer = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "completed", withExtension: "mp3")!)
    
    let repository = CoreDataSettingParamsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settingParams = repository.getSettingParams()
        
        let guidanceDisplayTime = Int(settingParams.guidanceDisplayTime)
        let interval = Int(settingParams.interval)
        self.initCount(interval)
        isEnabled = true
        // メインガイドを非同期で実行
        queue.async {
            self.proccessMainGuide(guidanceDisplayTime: guidanceDisplayTime, guideInterval: interval, upProbability: Int(settingParams.upProbability), isVoiceGuide: settingParams.isVoiceGuide)
        }
        
        let isTRoad = settingParams.isTRoad
        subGuideView.isHidden = !isTRoad
        if isTRoad {
            lotterySub()
            // サブガイドを非同期で実行
            queue.async {
                self.proccessSubGuide(tRoadInterval: Int(settingParams.tRoadInterval))
            }
        }
    }
    
    func proccessMainGuide(guidanceDisplayTime: Int, guideInterval: Int, upProbability: Int, isVoiceGuide: Bool) {
        var interval = guideInterval
        while true {
            var isCompleted: Bool = false
            if interval > 1 {
                // 一分待つ
                isCompleted = self.countMinute()
                if !isCompleted {
                    return
                }
                interval -= 1
                // 残り時間表示更新
                DispatchQueue.main.async {
                    self.remainingLabel.text = String(interval)
                }
                if isVoiceGuide { self.countPlayer.play() }
            } else if interval == 1 {
                // 一分待つ
                isCompleted = self.countLastOneMinute(isVoiceGuide: isVoiceGuide)
                if !isCompleted {
                    return
                }
                interval -= 1
            } else {
                if isVoiceGuide { self.completedPlayer.play() }
                // 実行
                DispatchQueue.main.async {
                    // 抽選して
                    self.lotteryMain(upProbability)
                    // 表示を切り替える
                    self.switchGuide(true)
                }
                // 案内表示持続
                isCompleted = self.countSec(sec: guidanceDisplayTime)
                if !isCompleted {
                    return
                }
                // 初期化
                interval = guideInterval
                self.initCount(interval)
            }
        }
    }
    
    func proccessSubGuide(tRoadInterval: Int) {
        var interval = tRoadInterval
        while true {
            if interval > 0 {
                let isCompleted = self.countMinute()
                if !isCompleted {
                    return
                }
                interval -= 1
            } else {
                DispatchQueue.main.async {
                    self.lotterySub()
                    interval = tRoadInterval
                }
            }
        }
    }
    
    func initCount(_ interval: Int) {
        DispatchQueue.main.async {
            self.unitLabel.text = "分"
            self.remainingLabel.text = String(interval)
            self.switchGuide(false)
        }
    }
    
    func countMinute() -> Bool {
        var sec = 60
        while sec > 0 {
            sleep(1)
            if !self.isEnabled {
                return false
            }
            sec -= 1
        }
        return true
    }
    
    func countSec(sec: Int) -> Bool{
        var remain = sec
        while remain > 0 {
            sleep(1)
            if !self.isEnabled {
                return false
            }
            remain -= 1
        }
        return true
    }
    
    func countLastOneMinute(isVoiceGuide: Bool) -> Bool {
        var sec = 60
        while sec > 0 {
            sleep(1)
            if !self.isEnabled {
                return false
            }
            sec -= 1
            if sec <= 10 {
                // 残り10秒
                if isVoiceGuide { self.countPlayer.play() }
                // 秒カウントに変更
                DispatchQueue.main.async {
                    self.unitLabel.text = "秒"
                    self.remainingLabel.text = String(sec)
                }
            }
        }
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func lotteryMain(_ upProbability: Int) {
        let random = Int.random(in: 1...100)
        if upProbability >= random {
            mainCatImage.image = UIImage(named: "up_message")!
        } else {
            let random = Int.random(in: 0...1)
            if random == 0 {
                mainCatImage.image = UIImage(named: "left_message")!
            } else {
                mainCatImage.image = UIImage(named: "right_message")!
            }
        }
    }
    
    func lotterySub() {
        let random = Int.random(in: 0...1)
        if random == 0 {
            subCatImage.image = UIImage(named: "left")!
        } else {
            subCatImage.image = UIImage(named: "right")!
        }
    }
    
    func switchGuide(_ isReady: Bool) {
        if isReady {
            message.text = "次の交差点を…"
        } else {
            message.text = "次の案内まで…"
        }
        remainingLabel.isHidden = isReady
        unitLabel.isHidden = isReady
        mainCatImage.isHidden = !isReady
        nyaLabel.isHidden = !isReady
    }
    
    @IBAction func tapStopButton(_ sender: Any) {
        isEnabled = false
        self.navigationController?.popViewController(animated: true)
    }
}
