//
//  MainButton.swift
//  WakeUp
//
//  Created by a on 10/14/25.
//

import SwiftUI

enum ButtonStyle {
    case `default`
    case text
    
    var backgroundColor: Color {
        switch self {
        case .`default`:
                .button
        case .text:
                .clear
        }
    }
    
    func textColor(disabled: Bool) -> Color {
        switch (self, disabled) {
        case (.default, false):
                .brand
        case (.default, true):
                .neutralSecondary
        case (.text, false):
                .tertiary
        case (.text, true):
                .neutralTertiary
        }
    }
}

struct MainButton: View {
    let title: String
    var disabled: Bool = false
    var buttonStyle: ButtonStyle = .default
    var action: (() -> ())?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(buttonStyle.textColor(disabled: disabled))
                .frame(maxWidth: .infinity, minHeight: 62)
        }
        .disabled(disabled)
        .background(buttonStyle.backgroundColor)
        .cornerRadius(16)
    }
}

#Preview {
    MainButton(title: "완료")
}
