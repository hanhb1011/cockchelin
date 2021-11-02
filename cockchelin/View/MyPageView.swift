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
                MyPageListItemView(title: "가진 재료 입력 >")
                }
                NavigationLink(destination: MyIngredientShowView()){
                MyPageListItemView(title: "가진 재료로 만들 수 있는 칵테일 >")
                }
                NavigationLink(destination: FavoriteCocktailView()){
                MyPageListItemView(title: "즐겨찾는 칵테일 >")
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
    
    var body: some View {
            HStack {
                Text(title)
                Spacer()
            }
    }
}

struct MyPageView_Previews: PreviewProvider {
    @State var hyoj = 0
    static var previews: some View {
        MyPageView()
    }
}
