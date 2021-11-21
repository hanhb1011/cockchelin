//
//  FavoriteCocktailView.swift
//  cockchelin
//
//  Created by 한효병 on 2021/11/02.
//

import SwiftUI

struct FavoriteCocktailView: View {
    var favoriteCocktailViewModel: FavoriteCocktailViewModel = FavoriteCocktailViewModel()
    
    var body: some View {
        if (favoriteCocktailViewModel.hasNothingToShow()) {
            CenterTextView(text: "즐겨찾는 칵테일이 없습니다.\n⭐️ 를 눌러 즐겨찾는 칵테일을 추가해주세요.")
                .navigationBarTitle(Text("즐겨찾는 칵테일"))
        }
        else {
            ScrollView(.vertical){
                HStack {Spacer()}
                VStack {
                    ForEach(favoriteCocktailViewModel.recipes.filter {
                        return favoriteCocktailViewModel.isFavorite(recipe: $0)
                    }.sorted(by: { recipe0, recipe1 in
                        recipe0.names[0] < recipe1.names[0]
                    })
                    ){section in
                        RecipeItemView(recipe: section)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle(Text("즐겨찾는 칵테일"))
            .padding(.horizontal, 15)
            .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
            .onAppear {
                favoriteCocktailViewModel.refresh()
            }
        }
        
    }
}

struct CenterTextView: View {
    var text: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(text)
                    .font(.system(size: 18))
                    .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255, opacity: 100))
                    .multilineTextAlignment(.center)
                Spacer()
            }
            Spacer()
        }
        .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
    }
    
}

struct FavoriteCocktailView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCocktailView()
    }
}
