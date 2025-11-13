//
//  RootView.swift
//  WakeUp
//
//  Created by a on 10/24/25.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        NavigationStack {
            MainView()
                .environmentObject(MainViewModel())
        }
    }
}

#Preview {
    RootView()
}
