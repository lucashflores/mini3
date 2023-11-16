//
//  Categories.swift
//  Mini3
//
//  Created by Gabriela Nunes on 15/11/23.
//

import SwiftUI

struct Categories: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(uiColor: .quaternaryLabel))
                .frame(width: 140, height: 24)
                .cornerRadius(20)
            HStack(){
                Image(systemName: "staroflife")
                    .font(.callout)
                    .foregroundColor(.white)
                Text("Categoria")
                    .font(.callout)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    Categories()
}
