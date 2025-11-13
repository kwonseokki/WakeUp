//
//  AppSelectionItem.swift
//  WakeUp
//
//  Created by a on 11/14/25.
//

import SwiftUI

struct AppSelectionItem: View {
    let appName: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image("")
                .resizable()
                .frame(width: 54, height: 54)
                .background(.buttonDisasbled)
                .cornerRadius(16)
            
            Text("카카오톡")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.neutral)
            Spacer()
            Image(.check)
                .renderingMode(.template)
                .foregroundStyle(isSelected ? .buttonDisasbled : .default)
        }
        .padding(16)
        .background(.black)
        .cornerRadius(16)
    }
}

#Preview {
    AppSelectionItem(appName: "", isSelected: false)
}
