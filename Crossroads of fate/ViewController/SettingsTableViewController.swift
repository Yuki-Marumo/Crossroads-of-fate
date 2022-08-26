//
//  SettingsViewController.swift
//  Crossroads of fate
//
//  Created by 丸茂優輝 on 2022/05/03.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let repository = CoreDataSettingParamsRepository()
    
    
    @IBOutlet weak var guidanceDisplayTimeStepper: UIStepper!
    @IBOutlet weak var guidanceDisplayTimeLabel: UILabel!
    
    @IBOutlet weak var intervalStepper: UIStepper!
    @IBOutlet weak var intervalLabel: UILabel!
    
    @IBOutlet weak var isTRoadSwitch: UISwitch!
    @IBOutlet weak var tRoadIntervalLabel: UILabel!
    
    @IBOutlet weak var isVoiceGuideSwitch: UISwitch!
    
    @IBOutlet weak var probabilitySlider: UISlider!
    @IBOutlet weak var upProbabilityLabel: UILabel!
    @IBOutlet weak var lrProbabilityLabel: UILabel!
    
    @IBOutlet weak var tRoadIntervalStepper: UIStepper!
    @IBOutlet weak var tRoadIntervalCell: UITableViewCell!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func guidanceDisplayTimeValueChange(_ sender: UIStepper) {
        let interval = String(format: "%.0f", sender.value)
        guidanceDisplayTimeLabel.text = String(interval)
    }
    
    @IBAction func intervalValueChange(_ sender: UIStepper) {
        let interval = String(format: "%.0f", sender.value)
        intervalLabel.text = String(interval)
    }
    
    @IBAction func switchTRoadGuide(_ sender: UISwitch) {
        cahngeTRoadGuideStatus(sender.isOn)
    }
    
    @IBAction func tRoadIntervalValueChange(_ sender: UIStepper) {
        let interval = String(format: "%.0f", sender.value)
        tRoadIntervalLabel.text = String(interval)
    }
    
    @IBAction func probabilitySlider(_ sender: UISlider) {
        let upProbability = String(format: "%.0f", sender.value)
        let lrProbability = String(format: "%.0f", 100 - sender.value)
        upProbabilityLabel.text = String(upProbability)
        lrProbabilityLabel.text = String(lrProbability)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settingParams = repository.getSettingParams()
        print("guidanceDisplayTime")
        print(settingParams.guidanceDisplayTime)
        print("interval")
        print(settingParams.interval)
        print("isTRoad")
        print(settingParams.isTRoad)
        print("tRoadInterval")
        print(settingParams.tRoadInterval)
        print("guidanceDisplayTime")
        print(settingParams.guidanceDisplayTime)
        guidanceDisplayTimeLabel.text = String(settingParams.guidanceDisplayTime)
        intervalLabel.text = String(settingParams.interval)
        isTRoadSwitch.isOn = settingParams.isTRoad
        isVoiceGuideSwitch.isOn = settingParams.isVoiceGuide
        upProbabilityLabel.text = String(settingParams.upProbability)
        lrProbabilityLabel.text = String(100 - settingParams.upProbability)
        guidanceDisplayTimeStepper.value = Double(settingParams.guidanceDisplayTime)
        intervalStepper.value = Double(settingParams.interval)
        tRoadIntervalStepper.value = Double(settingParams.tRoadInterval)
        probabilitySlider.value = Float(settingParams.upProbability)
        tRoadIntervalLabel.text = String(settingParams.tRoadInterval)
        cahngeTRoadGuideStatus(settingParams.isTRoad)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        repository.updateSettingParams(guidanceDisplayTime: Int(guidanceDisplayTimeLabel.text!)!, upProbability: Int(upProbabilityLabel.text!)!, isVoiceGuide: isVoiceGuideSwitch.isOn, isTRoad: isTRoadSwitch.isOn, interval: Int(intervalLabel.text!)!, tRoadInterval: Int(tRoadIntervalLabel.text!)!)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func cahngeTRoadGuideStatus(_ isEnabled: Bool) {
        if isEnabled {
            tRoadIntervalCell.backgroundColor = .white
            tRoadIntervalStepper.isEnabled = true
        } else {
            tRoadIntervalCell.backgroundColor = .systemGray
            tRoadIntervalStepper.isEnabled = false
        }
    }
}
