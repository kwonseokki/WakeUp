//
//  AlarmManager.swift
//  WakeUp
//
//  Created by a on 11/21/25.
//

import UserNotifications

final class AlarmManager {
    static let shared = AlarmManager()
    
    private let dataManager: CoreDataManager
    private let audioPlayer: AudioPlayerManager
    
    private init(dataManager: CoreDataManager = .shared, audioPlayer: AudioPlayerManager = .shared) {
        self.dataManager = dataManager
        self.audioPlayer = audioPlayer
    }
    
    /// 알람 추가
    func addAlarm(_ alarm: AlarmEntity) async {
        await dataManager.addAlarm(alarm: alarm)
    }
    
    /// 알람 업데이트
    func updateAlarm(_ alarm: AlarmEntity) {
        do {
            try dataManager.updateAlarm(alarm: alarm)
        } catch {
            print("Failure to update alarm: \(error)")
        }
    }
    
    /// 알람 삭제
    func removeAlarm(_ alarm: AlarmEntity) {
    }
    
    /// 알람 스케줄링
    func scheduleAlarmTask() async {
        
    }
    
}
