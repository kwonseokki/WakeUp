//
//  RootView.swift
//  WakeUp
//
//  Created by a on 10/24/25.
//

import SwiftUI

struct RootView: View {
    @State var isOnboarding = false
    
    var body: some View {
        ZStack {
            Color.customBackground.ignoresSafeArea(.all)
            
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
