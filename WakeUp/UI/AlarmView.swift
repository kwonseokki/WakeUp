//
//  AlarmView.swift
//  WakeUp
//
//  Created by a on 10/13/25.
//

import SwiftUI

struct AlarmView: View {
    @Binding var alarm: AlarmEntity    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom) {
                    Text("\(alarm.meridiem)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.neutral)
                    
                    Text("\(alarm.dateString)")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(.neutral)
                    Spacer()
                    
                    Toggle("", isOn: Binding(get: {
                        alarm.isActive
                    }, set: { isActive in
                        alarm.isActive = isActive
                    }))
                }
                HStack {
                    ForEach(Weekday.allCases, id: \.self) {
                        Text($0.dayName)
                            .foregroundStyle(alarm.repeatDay.contains($0) ? .neutral : .defaultSecondary)
                    }
                }
                .padding(.top, 8)
            }
            .padding(16)
        }
        .background(.default)
        .cornerRadius(16)
        .opacity(alarm.isActive ? 1 : 0.3)
    }
}

//#Preview {
//    AlarmView(isOn: .constant(true))
//}
