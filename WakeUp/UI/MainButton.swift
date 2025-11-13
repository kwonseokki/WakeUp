//
//  MainButton.swift
//  WakeUp
//
//  Created by a on 10/14/25.
//

import SwiftUI

struct MainButton: View {
    let title: String
    var disabled: Bool = false
    var action: (() -> ())?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.brand)
                .frame(maxWidth: .infinity, minHeight: 62)
        }
        .disabled(disabled)
        .background(disabled ? .buttonDisasbled : .button)
        .cornerRadius(16)
    }
}

#Preview {
    MainButton(title: "완료")
}
