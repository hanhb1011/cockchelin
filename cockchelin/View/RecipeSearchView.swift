//
//  Recipe.swift
//  pjt201010
//
//  Created by Hyojin Choi on 2020/10/10.
//  Copyright © 2020 Hyojin Choi. All rights reserved.
//

import SwiftUI

struct Post{
    let idid: Int
    let recipeName, detail, imgName: String
}

struct RecipeSearchView: View {
    @ObservedObject var recipeSearchViewModel: RecipeSearchViewModel
    @ObservedObject var filter: Filter
    @State var searchText = ""
    @State var isSearching = false
    
    init() {
        self.recipeSearchViewModel = RecipeSearchViewModel()
        self.filter = Filter()
        
    }
    
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    TextField("레시피 이름 또는 재료 입력", text: $searchText)
                        .padding(.leading, 24)
                        .padding(10)
                        .background(Color(red: 241/255, green: 241/255, blue: 245/255, opacity: 100))
                        .cornerRadius(12)
                        .onTapGesture(perform: {
                            isSearching = true
                        })
                        .overlay(
                            HStack{
                                Image(systemName: "magnifyingglass")
                                Spacer()
                                if isSearching{
                                    Button(action: {searchText = ""}, label:{Image(systemName: "xmark.circle.fill")
                                            .padding(.vertical)
                                    })
                                }
                            }
                                .padding(.horizontal, 12)
                                .foregroundColor(Color.gray)
                        )
                    NavigationLink(destination:Filterview(filter: filter)){Image(systemName: "slider.vertical.3")}
                    
                }
                .padding(.vertical, 5)
                
                ScrollView(.vertical, showsIndicators: false){
                    LazyVStack(spacing: 0){
                        ForEach((self.recipeSearchViewModel.recipes)
                                    .filter{"\($0)".lowercased().trimmingCharacters(in: .whitespaces).contains(searchText.lowercased() .trimmingCharacters(in: .whitespaces)) || searchText.isEmpty
                        }.filter {
                            if (filter.isEnabled) {
                                return $0.alcoholDegree <= Int(self.filter.maxDegree) && $0.alcoholDegree >= Int(self.filter.minDegree)
                            }
                            else {
                                return true
                            }
                        }.filter {
                            if (filter.isEnabled) {
                                if (filter.isMakeableSelected) {
                                    return filter.isMakeableRecipe(recipe: $0)
                                }
                                else {
                                    return true
                                }
                            }
                            else {
                                return true
                            }
                        }.filter {
                            if (filter.isEnabled) {
                                if (filter.isFavoriteSelected) {
                                    return $0.favoriteChecked
                                }
                                else {
                                    return true
                                }
                            }
                            else {
                                return true
                            }
                        }.filter {
                            if (filter.isEnabled) {
                                return filter.isSelectedColor(color:$0.liquidColor)
                            }
                            else {
                                return true
                            }
                        }.sorted(by: { recipe0, recipe1 in
                            recipe0.names[0] < recipe1.names[0]
                        })
                        ){section in
                            RecipeItemView(recipe: section)
                            Spacer()
                        }
                        
                    }
                }//ScrollView
                
            }.navigationBarTitle(Text("레시피"))
                .padding(.horizontal, 15)
                .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
        }
    }
}

struct RecipeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchView()
    }
}
