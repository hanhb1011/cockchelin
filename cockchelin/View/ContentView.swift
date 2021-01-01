//
//  MainTabBarController.swift
//  TabBarController_No_storyboard_swift
//
//  Created by Jeff Jeong on 2020/06/01.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import SwiftUI

struct ContentView: View{
    //let titleFontAttrs = [NSAttributedString.Key.font: UIFont(name : "MapoGoldenPier", size: 30)]
    
    init(){
        UITabBar.appearance().backgroundColor = .red
        UINavigationBar.appearance().backgroundColor = UIColor(named: "BackColor")
        //UINavigationBar.appearance().titleTextAttributes = titleFontAttrs as [NSAttributedString.Key : Any]
        //UINavigationBar.appearance().largeTitleTextAttributes = titleFontAttrs as [NSAttributedString.Key : Any]
    }
    
    @State var selected = 0 //시작tab index
    @State var animate = false
    @State var endSplash = false
    
    var body: some View{
        ZStack{
            TabView(selection: $selected){
                HomeView().tabItem({
                    Image(systemName: "house")
                        .font(.title)
                    Text ("\(Constants.TabBarText.tabBar0)")
                }).tag(0)
                
                RecipeSearchView().tabItem({
                    Image(systemName: Constants.TabBarImageName.tabBar1)
                        .font(.title)
                    Text ("\(Constants.TabBarText.tabBar1)")
                }).tag(1)
                
                BookmarkView().tabItem({
                    Image(systemName: Constants.TabBarImageName.tabBar2)
                        .font(.title)
                    Text ("\(Constants.TabBarText.tabBar2)")
                }).tag(2)
                
            }.accentColor(Color.red)
            
            ZStack{
                Color("PointColor")
                
                Image("logo")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: animate ? .fill : .fit)
                    .frame(width: animate ? nil : 120, height: animate ? nil : 120)
                 //scale view
                    .scaleEffect(animate ? 3 : 1)
                //set width to avoid oversize
                    .frame(width: UIScreen.main.bounds.width)
                
            }
            .ignoresSafeArea(.all, edges: .all)
            .onAppear(perform: animateSplash )
            //hide view after finish
            .opacity(endSplash ? 0 : 1)
        }
    }
    
    func animateSplash(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.35){
            withAnimation(Animation.easeOut(duration: 0.45)){
                animate.toggle()
            }
            withAnimation(Animation.easeOut(duration: 0.35)){
                endSplash.toggle()
            }
        }
    }
}

/*
 struct ContentView_Previews: PreviewProvider{
 struct var previews: some View{
 ContentView()
 }
 }*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
