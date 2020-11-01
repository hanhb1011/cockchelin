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
        }.padding(.top, -20)
        
    }
}

struct TodayCocktailView: View{
    var body: some View{
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
            }//.frame(height:200)
        }
    }
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
                .font(Font.custom("MapoGoldenPier", size: 13))
        }.frame(width:125 , height:150)
    }
}

struct BestCocktailView: View{
    var body: some View{
        VStack(alignment: .leading){
            Text("BEST cocktail").font(.headline)
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
