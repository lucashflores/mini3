//
//  Categories.swift
//  Mini3
//
//  Created by Gabriela Nunes on 15/11/23.
//

import SwiftUI

struct Categories: View {
    
    var category: String
    private var icon: String = ""
    
    init(category: String) {
        self.category = category
        
        switch category {
        case CategoryModel.categories[0].name:
            icon = CategoryModel.categories[0].icon
            break
        case CategoryModel.categories[1].name:
            icon = CategoryModel.categories[1].icon
            break
        case CategoryModel.categories[2].name:
            icon = CategoryModel.categories[2].icon
            break
        case CategoryModel.categories[3].name:
            icon = CategoryModel.categories[3].icon
            break
        case CategoryModel.categories[4].name:
            icon = CategoryModel.categories[4].icon
            break
        case CategoryModel.categories[5].name:
            icon = CategoryModel.categories[5].icon
            break
        default:
            icon = "figure.walk"
            break
        }
    }
    var body: some View {
        ZStack{
            
            HStack(){
                Image(systemName: icon)
                    .font(.callout)
                    .foregroundColor(.white)
                Text(category)
                    .font(.callout)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .background{
                Rectangle()
                    .foregroundColor(Color(uiColor: .quaternaryLabel))
                    .frame(height: 24)
                    .cornerRadius(20)
            }
        }
    }
}

#Preview {
    Categories(category: CategoryModel.categories[0].name)
}
