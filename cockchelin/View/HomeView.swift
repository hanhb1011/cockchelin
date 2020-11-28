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
                    .fill(Color.themeSecondary)
                    .frame(height:100.0)
                    .edgesIgnoringSafeArea(.top)
                    .edgesIgnoringSafeArea(.bottom)
                    .overlay(Text("Cockchelin")
                                .font(Font.custom("MapoGoldenPier", size : 35))
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
                    
                    //RoundedRectangle(cornerRadius: 20)
                      //      .frame(height:150)

                }.foregroundColor(Color.themeForeground)
                .padding(.horizontal)
                }
            }//VStack
        }//ZStack
        /*
        NavigationView{

            List{
                ScrollView{
                    HStack{
                        TextField("Search here", text: $searchText)
                            .padding(.leading, 24)
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(6)
                    //.padding(.horizontal)
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            Image(systemName: "xmark.circle.fill")
                        }.padding(.horizontal,12)
                            .foregroundColor(Color.gray)
                    )
                }
                
                //today's cocktail list
                TodayCocktailView()
                
                //best cocktail list
                BestCocktailView()
                
                //favorite cocktail list
                FavoriteView()
                
                //temp
                TempView()
                
            }.navigationBarTitle(Text("당신만의, 칵테일🍸"))
           
        }.padding(.top, -20) //Navigation
         */
    }
}

struct RecipeCardView: View{
    var body: some View{
        VStack{
            Image("todayCocktail")
                .resizable()
                .scaledToFit()
           
            VStack(alignment: .leading, spacing: 12){
                 Text("오늘의 칵테일")//여기 변수 넣어야
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
            .padding(.bottom, 12)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color:Color("BackgroundColor"), radius: 8, x:0, y:0)
    }
}
struct TodayCocktailView: View{
    var body: some View{
        VStack(alignment: .center, spacing:20){
            RecipeCardView()
        }
        /*
        VStack(alignment: .leading){
            Text("오늘처럼 비오는 날엔💦")
                //.font(.headline)
                .font(Font.custom("MapoGoldenPier", size : 20))
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
            }//SCROLL
        }//VStack
 */
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
        VStack(alignment: .leading){
            Image("recImg_0")
                .resizable()
                .renderingMode(.original).cornerRadius(5)
                .clipShape(Circle())
                .frame(width:95, height:80)
                .clipped()
            Text("Daiquiri")
                .foregroundColor(.primary).lineLimit(nil)
                .padding(.leading, 0)
                .font(Font.custom("MapoGoldenPier", size: 20))
            Text("우울할 땐 부드러움으로 마음을 녹여요!").lineLimit(nil)
                .padding(.leading, 0)
                .foregroundColor(Color.black)
                .font(Font.custom("MapoGoldenPier", size: 13))
        }.frame(width:125 , height:150)
    }
}

struct bestItem{
    var id : Int
    let image, title, content : String
}
struct BestCocktailView: View{
    /*
    let cocktails:[bestItem] = [
        bestItem(id:0, image:"rusty-nail", title: "number 1", content: "20"),
        bestItem(id:1, image:"margarita", title: "number 2", content: "20"),
        bestItem(id:2, image:"rusty-nail", title: "number 3", content: "20"),
        bestItem(id:3, image:"margarita", title: "number 4", content: "20"),
    ]
    var body: some View{
        VStack{
            Image("margarita")
                .resizable()
                .scaledToFit()
           
            VStack(alignment: .leading, spacing: 9){
                 Text("베스트 칵테일")//여기 변수 넣어야
                    .font(.system(.title, design:.serif))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("PointColor"))
                    .lineLimit(1)

            }
            .padding()
            .padding(.bottom, 12)
        }.frame(width:150, height: 150)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color:Color("BackgroundColor"), radius: 8, x:0, y:0)
    }*/
   var body: some View{
        VStack(alignment: .leading){
            Text("BEST cocktail").font(.headline)
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
        }
    }
}

struct BestListView: View{
    let bestitem: bestItem
    
    var body: some View{
        VStack{
            Image(bestitem.image)
                .resizable()
                .frame(width:80, height:80)
                .cornerRadius(12)
            Text(bestitem.title)
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }
}

struct FavoriteView: View{
    var body: some View{
        VStack(alignment: .leading){
            Text("Favorite cocktail").font(.headline)
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
            }//.frame(height:200)
        }
    }
}

struct TempView: View{
    var body: some View{
        VStack(alignment: .leading){
            Text("임시입니다").font(.headline)
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
            }//.frame(height:200)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
