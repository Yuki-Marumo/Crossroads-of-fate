//
//  SettingParamsRepository.swift
//  Crossroads of fate
//
//  Created by 丸茂優輝 on 2022/05/04.
//

import Foundation

protocol SettingParamsRepository {
    func getSettingParams() -> SettingParams
    func updateSettingParams(guidanceDisplayTime: Int, upProbability: Int, isVoiceGuide: Bool, isTRoad: Bool, interval: Int, tRoadInterval: Int)
}
