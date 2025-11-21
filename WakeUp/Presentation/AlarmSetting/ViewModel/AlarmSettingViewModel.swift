//
//  AlarmSettingViewModel.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import Combine
import SwiftUI

enum AlarmSettingPath: Hashable {
    case sound
    case mission
}

final class AlarmSettingViewModel: ObservableObject {
    @Published var path: [AlarmSettingPath] = []
    @Published var weekDays: Set<Weekday> = []
    @Published var time = Date()
    
    var alarm: AlarmEntity?
        
    private let alarmManager: AlarmManager
    
    init(alarm: AlarmEntity? = nil, alarmManager: AlarmManager = AlarmManager.shared) {
        self.alarmManager = alarmManager
        self.alarm = alarm
        self.time = alarm?.time ?? Date()
        self.weekDays = Set(alarm?.repeatDay ?? [])
    }
    
    func goToSoundView() {
        path.append(.sound)
    }
    
    func goToMissionView() {
        path.append(.mission)
    }
    
    func selecteDay(_ day: Weekday) {
        if weekDays.contains(day) {
            weekDays.remove(day)
        } else {
            weekDays.insert(day)
        }
    }
    
    func saveAlarm() {
        let content = UNMutableNotificationContent()
        content.body = "test"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("sampleSound.caf"))
        
        let hour = Calendar.current.component(.hour, from: time)
        let minute = Calendar.current.component(.minute, from: time)
//        let center = UNUserNotificationCenter.current()
        
        let alarmGroupId = UUID().uuidString
        var requests = Set<UNNotificationRequest>()
        
        weekDays.forEach { weekDay in
            let id = "\(alarmGroupId)-\(weekDay.rawValue)"
            var date = DateComponents()
            date.hour = hour
            date.minute = minute
            date.weekday = weekDay.rawValue
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            
            requests.insert(request)
        }
        
        let alarmEntity = AlarmEntity(
            id: alarmGroupId,
            time: time,
            isActive: true,
            repeatDay: Array(weekDays)
        )
        
        Task {
            await alarmManager.addAlarm(alarmEntity)
        }
    }
    
    func updateAlarm() {
        if let alarm {
            var updateAlarm = alarm
            updateAlarm.time = time
            
            // 날짜를 수정한경우
            let oldWeekDays = Set(updateAlarm.repeatDay)
            let removedWeekDay = oldWeekDays.subtracting(weekDays)
            let addWeekDay = weekDays.union(oldWeekDays).subtracting(removedWeekDay)
            
            let center = UNUserNotificationCenter.current()
            
            // 기존 알림 삭제
            let removeRequestIDs = removedWeekDay.map { "\(updateAlarm.id)-\($0.rawValue)" }
            center.removePendingNotificationRequests(withIdentifiers: removeRequestIDs)
            
            let hour = Calendar.current.component(.hour, from: time)
            let minute = Calendar.current.component(.minute, from: time)
            let content = UNMutableNotificationContent()
            
            content.body = "test"
            content.sound = UNNotificationSound(named: UNNotificationSoundName("sampleSound.caf"))
                        
            var requests = Set<UNNotificationRequest>()
            
            // 변경된 알람 추가
            addWeekDay.forEach {
                let requestId = "\(updateAlarm.id)-\($0.rawValue)"
                var date = DateComponents()
                date.hour = hour
                date.minute = minute
                date.weekday = $0.rawValue
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: requestId, content: content, trigger: trigger)
                requests.insert(request)
                center.add(request)
            }
            
            updateAlarm.repeatDay = Array(addWeekDay)
            
//            do {
//                try dataManager.updateAlarm(alarm: updateAlarm)
//            } catch {
//                
//            }
        }
    }
}
