//
//  HomeView.swift
//  cocktail_201008
//
//  Created by Hyojin Choi on 2020/10/08.
//  Copyright © 2020 Hyojin Choi. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    init(){
        self.homeViewModel = HomeViewModel()
    }
    
    var body: some View {
        ZStack{
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Rectangle()
                    .fill(Color.themeBackground)
                    .frame(height:100.0)
                    .edgesIgnoringSafeArea(.top)
                    .edgesIgnoringSafeArea(.bottom)
                    .overlay(Text("Cockchelin")
                                .font(Font.system(size: 35))
                                .fontWeight(.bold)
                                .padding(.bottom,20.0))
                    .frame(height:60.0)
                Spacer()
                
                //best 칵테일 (조회수 기준?)
                ScrollView{
                    Group{
                        TodayCocktailView(recipe: homeViewModel.getTodaysCocktail())
                        
                        BestCocktailView(title: "Recently Viewed cocktails", recipes: homeViewModel.getRecentlyViewedCocktails(maxCount: 5))
                        
                        NewUpdatedView()
                        
                    }.foregroundColor(Color.themeForeground)
                    .padding(.horizontal)
                }
                .onAppear {
                    homeViewModel.refresh()
                }
            }//VStack
        }//ZStack
        
    }
}

struct RecipeCardView: View{
    var recipe: Recipe
    
    var body: some View{
        VStack(alignment: .leading) {
            Text("Today's Cocktail")
                .bold()
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
            
            //.font(Font.system(size: 40))
        }
        VStack{
            Image("todayCocktail")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
            
            VStack(alignment: .leading, spacing: 5){
                Text(recipe.names[0])
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                    .lineLimit(1)
                
                Text("지친 마음, \(recipe.names[0]) 한잔으로 쓸어내리는 건 어때요?")
                    .font(.system(.body, design:.serif))
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
                    .italic()
            }
            .padding()
            .padding(.top, -15)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color:Color("BackgroundColor"), radius: 8, x:0, y:0)
    }
}
struct TodayCocktailView: View{
    var recipe: Recipe
    var body: some View{
        VStack(alignment: .leading){
            RecipeCardView(recipe: recipe)
        }
    }
}

//today's cocktail list
struct GroupView: View{
    var recipe: Recipe
    var body: some View{
        VStack{
            Image("temp")
                .resizable()
                //.scaledToFit()
                .frame(width: 130, height: 110, alignment: .center)
                .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 5){
                Text(recipe.names[0])
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
            }
            .padding(10)
            .padding(.top, -17)
            //.padding(.bottom, 4)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color:Color("BackgroundColor"), radius: 8, x:0, y:0)
    }
}

struct bestItem{
    var id : Int
    let image, title, content : String
}
struct BestCocktailView: View{
    
    var title: String
    var recipes: [Recipe]
    
    var body: some View{
        VStack(alignment: .leading){
            Text(title).bold()
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
            ScrollView(.horizontal){
                VStack(alignment: .leading){
                    HStack{
                        ForEach(recipes) { recipe in
                            GroupView(recipe: recipe)
                        }
                    }
                }
            }
        }.padding(.top, 5)
    }
}

struct IngredientsCell: View{
    var body: some View{
        ZStack{
            VStack(alignment: .leading){
                Text("Brandy")
                    .font(.headline)
                    .foregroundColor(Color("PointColor"))
                    .padding(.top, 8)
                    .padding(.leading)
                
                HStack{
                    Text("특징?")
                        .font(.subheadline).bold()
                        .foregroundColor(Color("PointColor"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.25))
                        )
                        .frame(width: 80, height: 24)
                    
                    Image("june-bug")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                        .padding([.bottom, .trailing], 4)
                        .cornerRadius(10)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        //.shadow(color: .blue, radius: 6, x: 0, y: 0)
    }
}

struct IngredientsView: View{
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Cocktail Ingredients")
                .font(.headline)
                .foregroundColor(Color("PointColor"))
            
            ScrollView{
                LazyVGrid(columns: gridItems, spacing:15) {
                    ForEach(0..<4){_ in
                        IngredientsCell()
                    }
                }
            }
            .navigationTitle("Ingredients")
            .foregroundColor(Color("PointColor"))
        }.frame(height: 290)
    }
}

//new updated items
class ListViewModel: ObservableObject{
    @Published var items = [
        Item(name: "cocktail0", details: "Strong", image: "black-russian", price: 20),
        Item(name: "cocktail1", details: "Extreme Strong", image: "black-russian", price: 20),
        Item(name: "cocktail2", details: "Medium", image: "black-russian", price: 20),
        Item(name: "cocktail3", details: "Strong", image: "black-russian", price: 20),
    ]
}

struct NewUpdatedView: View{
    @StateObject var listData = ListViewModel()
    @ObservedObject var recipeSearchViewModel: RecipeSearchViewModel
    @ObservedObject var filter: Filter
    @State var isSearching = false
    
    init() {
        self.recipeSearchViewModel = RecipeSearchViewModel()
        self.filter = Filter()
    }
    
    var body: some View{
        
        VStack(alignment: .leading){
            Text("Updated Cocktails")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255, opacity: 100))
            
            //Item list view..
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(spacing: 0){
                    let totalCount = (self.recipeSearchViewModel.recipes.count)
                    
                    //last updated 10 list
                    ForEach(totalCount-10..<totalCount){section in
                        RecipeItemView(recipe: self.recipeSearchViewModel.recipes[section])
                        
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color:Color("BackgroundColor"), radius: 8, x:0, y:0)
                    
                }
            }//ScrollView
        }.padding(.top, 5)
    }
    
    func getIndex(item: Item)->Int{
        return listData.items.firstIndex{(item1)->Bool in
            return item.id == item1.id
        } ?? 0
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
        }
    }
}
