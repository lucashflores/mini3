//
//  FinishAddingStopsvIEW.swift
//  Mini3
//
//  Created by Lucas Flores on 15/11/23.
//

import SwiftUI

struct FinishAddingStopsView: View {
    var body: some View {
        VStack {
            Spacer()
            Button {
                print("finish")
            } label: {
                HStack {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.white)
                        .bold()
                    Text("Finish adding stops")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .bold))
                }
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 35))
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    FinishAddingStopsView()
}
