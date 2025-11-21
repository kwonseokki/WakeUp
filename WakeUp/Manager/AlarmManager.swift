//
//  AlarmManager.swift
//  WakeUp
//
//  Created by a on 11/22/25.
//


import UserNotifications

final class AlarmManager {
    static let shared = AlarmManager()
    
    private let dataManager: CoreDataManager
    private let audioPlayer: AudioPlayerManager
    private var alarmQueue = AlarmQueue(sort: {
        if !$0.isActive { return false }
        return $0.time.getTime < $1.time.getTime
    })
    private var scheduledAlarm: AlarmEntity?
    
    private init(dataManager: CoreDataManager = .shared, audioPlayer: AudioPlayerManager = .shared) {
        self.dataManager = dataManager
        self.audioPlayer = audioPlayer
        self.buildQueue()
    }
    
    /// 큐 구성
    private func buildQueue() {
        dataManager.fetchAlarm().toEntities().forEach {
            alarmQueue.insert($0)
        }
        scheduleAlarmTask()
    }
    
    /// 알람 추가
    func addAlarm(_ alarm: AlarmEntity) async {
        do {
            try await dataManager.addAlarm(alarm: alarm)
            alarmQueue.insert(alarm)
            scheduleAlarmTask()
        } catch {
            
        }
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
    func scheduleAlarmTask() {
        guard let dequeAlarm = alarmQueue.peek() else { return }
        
        // 새로운 알람이 없다면 이전 알람을 유지
        if let prev = scheduledAlarm {
            if prev.id == dequeAlarm.id && prev.time == dequeAlarm.time {
                return
            }
        }
        
        scheduledAlarm = dequeAlarm
        
        let interval = dequeAlarm.time.getTime.timeIntervalSinceNow
        
        // 오디오 세션 활성화
        audioPlayer.play(atTime: interval, volume: 0.5)
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "알람"
        content.body = "알람테스트"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: dequeAlarm.id,
            content: content,
            trigger: trigger
        )
        
        center.add(request)
    }
}
