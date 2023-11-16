//
//  OnboardingView.swift
//  Mini3
//
//  Created by Lucas Flores on 15/11/23.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State var currentPage = 1
    
    var body: some View {
        ZStack {
            TabView(selection: $currentPage) {
                
                OnboardingFirstPage()
                    .tag(1)
                
                OnboardingSecondPage()
                    .tag(2)
                    
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            
            VStack {
                Spacer()
                
                HStack {
                    Circle()
                        .frame(width: 11, height: 11)
                        .foregroundStyle(currentPage == 1 ? .secondary : .quaternary)
                    
                    Circle()
                        .frame(width: 11, height: 11)
                        .foregroundStyle(currentPage == 1 ? .quaternary : .secondary)
                    Spacer()
                    
                    Button {
                        if (currentPage == 1) {
                            withAnimation(.linear(duration: 1)){
                                currentPage = 2
                            }
                        }
                        else {
                            UserDefaults.standard.setValue(true, forKey: "HasSeenOnboarding")
                            withAnimation(.easeOut(duration: 0.5)){
                                hasSeenOnboarding = true
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: "chevron.right.circle.fill")
                                .foregroundStyle(.white)
                            Text(currentPage == 1 ? "Next" : "Start")
                                .foregroundStyle(.white)
                        }
                        .animation(nil, value: UUID())
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background(currentPage == 1 ? .alaranjado : .azulEscuro)
                        .clipShape(RoundedRectangle(cornerRadius: 35))
                        
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 30)
                .padding(.bottom, 40)
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
