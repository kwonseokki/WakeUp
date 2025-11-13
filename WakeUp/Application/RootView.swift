//
//  RootView.swift
//  WakeUp
//
//  Created by a on 10/24/25.
//

import SwiftUI

struct UserDefaultKey {
    static let isOnboarding = "isOnboarding"
}

struct RootView: View {
    @AppStorage(UserDefaultKey.isOnboarding) private var isOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKey.isOnboarding)
    
    var body: some View {
        Group {
            if isOnboarding {
                MainView()
                    .environmentObject(MainViewModel())
            } else {
                OnboardingView()
            }
        }
    }
}

#Preview {
    RootView()
}
