//
//  ScreenTimePermissionView.swift
//  WakeUp
//
//  Created by a on 11/14/25.
//

import SwiftUI

struct ScreenTimePermissionView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if viewModel.isRequestingPermission {
                Text("스크린타임 권한을\n요청하고 있어요")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.neutral)
                    .padding(.top, 48)
                    .multilineTextAlignment(.center)
                
                Spacer()
                ProgressView()
                    .controlSize(.extraLarge)
                    .tint(.tertiary)
            } else {
                Text("스크린타임 권한을\n꼭 허용해주세요")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.neutral)
                    .padding(.top, 48)
                    .multilineTextAlignment(.center)
                
                Text("아침 잠금을 사용하기 위해서 꼭 필요해요\n아래의 화면이 뜨면 계속을 눌러주세요")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.tertiary)
                    .padding(.top, 12)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            MainButton(title: "다음으로") {
                                viewModel.navigate(to: .appRecommendation)
//                viewModel.requestScreenTimePermission()
            }
        }
        .padding(.horizontal, 16)
        .background(.customBackground)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ScreenTimePermissionView()
}
