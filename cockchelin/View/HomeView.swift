//
//  HomeView.swift
//  cocktail_201008
//
//  Created by Hyojin Choi on 2020/10/08.
//  Copyright © 2020 Hyojin Choi. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var searchText = ""
    
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
                    //오늘의 칵테일
                    TodayCocktailView()
                
                    //best cocktail list
                    BestCocktailView()
                    
                    IngredientsView()
                    
                    NewUpdatedView()
                    
                }.foregroundColor(Color.themeForeground)
                .padding(.horizontal)
                }
            }//VStack
        }//ZStack

    }
}

struct RecipeCardView: View{
    var body: some View{
        VStack(alignment: .leading) {
            Text("Today's Cocktail")
                .font(.system(.title, design:.serif))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.headline)
                .foregroundColor(Color("PointColor"))
                
                //.font(Font.system(size: 40))
        }
        VStack{
            Image("todayCocktail")
                .resizable()
                .scaledToFit()
                .frame(width: 290, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.top, 10)
           
            VStack(alignment: .leading, spacing: 12){
                 Text("칵테일 이름")//여기 변수 넣어야
                    .font(.system(.title, design:.serif))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("PointColor"))
                    .lineLimit(1)
                    
                Text("지친 마음, ㅇㅇㅇ 한잔으로 쓸어내리는 건 어때요?")
                    .font(.system(.body, design:.serif))
                    .foregroundColor(Color.gray)
                    .italic()
            }
            .padding()
            .padding(.bottom, 8)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color:Color("BackgroundColor"), radius: 8, x:0, y:0)
    }
}
struct TodayCocktailView: View{
    var body: some View{
        VStack(alignment: .leading, spacing:20){
            RecipeCardView()
        }
    }//VIEW
}

//Button Click event
struct GroupDetailView: View{
    var body: some View{
        Text("이미지 클릭 시 여기로")
    }
}

//today's cocktail list
struct GroupView: View{
    var body: some View{
        VStack{
            Image("temp")
                .resizable()
                //.scaledToFit()
                .frame(width: 130, height: 110, alignment: .center)
                .padding(.top, 5)
           
            VStack(alignment: .leading, spacing: 5){
                 Text("베스트 n등")//여기 베스트순으로 indexing 넣어야
                    //.font(.system(.title, design:.serif))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(Font.system(size: 15))
                    .foregroundColor(Color("PointColor"))
                    .lineLimit(1)
                    
                Text("베스트 n등에 걸맞는 멋진멘트")
                    //.font(.system(.body, design:.serif))
                    .font(Font.system(size: 10))
                    .foregroundColor(Color.gray)
                    .italic()
            }
            .padding()
            .padding(.top, -15)
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
   var body: some View{
        VStack(alignment: .leading){
            Text("BEST Cocktail")
                .font(.headline)
                .foregroundColor(Color("PointColor"))
            ScrollView(.horizontal){
                VStack(alignment: .leading){
                    HStack{
                        NavigationLink(destination:
                        GroupDetailView()){
                            GroupView()
                        }
                        GroupView()
                        GroupView()
                        GroupView()
                        GroupView()
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
    @State var searchText = ""
    @State var isSearching = false
    
    init() {
        self.recipeSearchViewModel = RecipeSearchViewModel()
        self.filter = Filter()
    }
    
   var body: some View{
    
        VStack(alignment: .leading){
            Text("Updated Cocktail!")
                .font(.headline)
                .foregroundColor(Color("PointColor"))
           
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
