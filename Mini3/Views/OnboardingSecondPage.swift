//
//  OnboardingSecondPage.swift
//  Mini3
//
//  Created by Lucas Flores on 15/11/23.
//

import SwiftUI

struct OnboardingSecondPage: View {
    var body: some View {
        ZStack {
            Color.alaranjado
                .ignoresSafeArea()
            
            Image("OnboardingAppScreen")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 240)
            
            
            VStack(alignment: .trailing, spacing: 40) {
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Just three")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.onboardingMainText)
                        .frame(height: 30)
                    Text("simple steps")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.onboardingMainText)
                        .foregroundStyle(.azulEscuro)
                        .lineSpacing(5)
                }
                
                Text("1. Build your own tour with its stops\n2. Jot down the key highlights about them\n3. Check your notes whenever you need!")
                    .lineLimit(nil)
                    .font(.onboardingSubText)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 100)
            .padding(.horizontal, 12)
        }

    }
}

#Preview {
    OnboardingSecondPage()
}
