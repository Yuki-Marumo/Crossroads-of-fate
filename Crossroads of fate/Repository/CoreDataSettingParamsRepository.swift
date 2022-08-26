//
//  CoreDataSettingParamsRepository.swift
//  Crossroads of fate
//
//  Created by 丸茂優輝 on 2022/05/04.
//

import UIKit
import CoreData

struct CoreDataSettingParamsRepository: SettingParamsRepository {
    private var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer

    func getSettingParams() -> SettingParams {
        let context = persistentContainer.viewContext
        let fetchRequest = SettingParams.fetchRequest()
        let settingParamsList = try! context.fetch(fetchRequest)
        if settingParamsList.isEmpty {
            NSEntityDescription.insertNewObject(forEntityName: "SettingParams", into: context)
            try! context.save()
            return getSettingParams()
        }
        return settingParamsList[0]
    }

    func updateSettingParams(guidanceDisplayTime: Int, upProbability: Int, isVoiceGuide: Bool, isTRoad: Bool, interval: Int, tRoadInterval: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest = SettingParams.fetchRequest()
        let settingParams = try! context.fetch(fetchRequest)[0]
        settingParams.guidanceDisplayTime = Int16(guidanceDisplayTime)
        settingParams.upProbability = Int16(upProbability)
        settingParams.isVoiceGuide = isVoiceGuide
        settingParams.isTRoad = isTRoad
        settingParams.interval = Int16(interval)
        settingParams.tRoadInterval = Int16(tRoadInterval)
        try! context.save()
    }
}
