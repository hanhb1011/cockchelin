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
    @State var searchText = ""
    @State var isSearching = false
    
    //여기가 파일 리스트들
    let posts: [Post] = [
        .init(idid: 0, recipeName: "Godmother",
              detail: "delicious, 여기가 설명란",
              imgName: "best_0"),
        .init(idid: 1, recipeName: "Godfather",
              detail: "spicy, 여기가 설명란",
              imgName: "best_1")
    ]
    
    let recipe = RecipeModel.loadSavedRecipes()
    
    var body: some View {
        NavigationView{
            List{
                ScrollView{
                    HStack{
                    HStack{
                        TextField("Search here", text: $searchText)
                            .padding(.leading, 24)
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(6)
                    //.padding(.horizontal)
                    .onTapGesture(perform: {
                     isSearching = true
                    })
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            if isSearching{
                                Button(action: {searchText = ""}, label:{                    Image(systemName: "xmark.circle.fill")
                                    .padding(.vertical)
                                })
                            }
                        }.padding(.horizontal, 12)
                            .foregroundColor(Color.gray)
                    )
                        NavigationLink(destination:RangeSlider()){Image(systemName: "slider.vertical.3")}
                }
                    
                }
                
                //Cocktail Recipe list
                ForEach((recipe).filter({"\($0)".lowercased()
                                            .contains(searchText.lowercased())||searchText.isEmpty})){
                    section in

                    
                    if(section.alcoholDegree <=
                            50){
                   ItemRow(item: section)
                    }
                }
                
            }.navigationBarTitle(Text("Cockchelin🍸"))
        }.padding(.top, -20)
    }
}

//recipe list
struct CommonRecipeView: View{
    let post: Post
    
    var body: some View{
        VStack(alignment: .leading, spacing : 16){
            HStack{
                Image(post.imgName)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width:80, height:80)
                    .clipped()
                VStack(alignment:.leading){
                    Text(post.recipeName).font(.headline)
                    Text(post.detail).font(.subheadline)
                }.padding(.leading, 8)
            }.padding(.leading, 16).padding(.top, 8)
        }.padding(.leading, -20).padding(.bottom, 8)
    }
}

struct ItemRow: View {
    var item: Recipe
 
    var body: some View {
        NavigationLink(destination: RecipeView(recipe: item)){
        VStack(alignment: .leading, spacing : 16){
        HStack{
            Image(systemName: "star.fill")
                .resizable()
                .clipShape(Circle())
                .frame(width:80, height:80)
                .clipped()
        VStack(alignment: .leading){
            Text(item.names[0]).font(.headline)
            HStack{
                ForEach(item.ingredients){ section in
                Text(section.names[0])
            }
            }
            Text(item.glassType.rawValue).font(.subheadline)
            Text("Degree : \(item.alcoholDegree)%").font(.subheadline)

        }.padding(.leading, 8)
        }.padding(.leading, 16).padding(.top, 8)
        }.padding(.leading, -20).padding(.bottom, 8)
        }}
}

/*
struct RecipeView: View{
    var item : Recipe
    
    var body: some View{
        VStack{
            Image(item.mainImage).resizable().frame(width : 450, height: 400)
            Text(item.RecipeInformation).padding()
        }.navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}
*/

struct RecipeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchView()
    }
}



/*
var id = UUID()
var name: String
let alcoholDegree: Int
var ingredients: [Ingredient]
var favoriteChecked: Bool
var RecipeInformation: String
let techniqueType: TechniqueType
var lastTimeRecipeOpened: Date
let latitude: Double
let longitude: Double
let liquidColor: LiquidColorType
let glassType: String
*/
