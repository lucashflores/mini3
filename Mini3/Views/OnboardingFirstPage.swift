//
//  OnboardingFirstPage.swift
//  Mini3
//
//  Created by Lucas Flores on 15/11/23.
//

import SwiftUI

struct OnboardingFirstPage: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            Image("OnboardingManRunning")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 120)
            
            
            VStack(alignment: .trailing, spacing: 40) {
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Your tour notes")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.onboardingMainText)
                        .frame(height: 30)
                    Text("quick and easy")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.onboardingMainText)
                        .foregroundStyle(.azul)
                        .lineSpacing(5)
                }
                
                Text("We help you remember all the key\nhighlights in your tour.")
                    .lineLimit(nil)
                    .font(.onboardingSubText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 75)
            .padding(.horizontal, 12)
        }
    }
}

#Preview {
    OnboardingFirstPage()
}
