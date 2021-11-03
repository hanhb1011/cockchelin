//
//  BookmarkView.swift
//  cockchelin
//
//  Created by Hyojin Choi on 2020/12/21.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: MyIngredientAddView()){
                    MyPageListItemView(title: "가진 재료 입력")
                }
                NavigationLink(destination: MyIngredientShowView()){
                    MyPageListItemView(title: "가진 재료로 만들 수 있는 칵테일")
                }
                NavigationLink(destination: FavoriteCocktailView()){
                    MyPageListItemView(title: "즐겨찾는 칵테일")
                }
                Spacer()
            }
            .padding()
            .navigationTitle("마이페이지")
            .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
        }
    }
}

struct MyPageListItemView: View {
    var title: String
    var subtitle: String?
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 70/255, green: 70/255, blue: 70/255, opacity: 100))
                    .padding(.bottom, 0.5)
                    .lineLimit(1)
                
            }.padding(.leading, 8)
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color(red: 70/255, green: 70/255, blue: 70/255, opacity: 100))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
}


struct MyPageView_Previews: PreviewProvider {
    @State var hyoj = 0
    static var previews: some View {
        MyPageView()
    }
}
