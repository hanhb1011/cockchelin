//
//  MainTabBarController.swift
//  TabBarController_No_storyboard_swift
//
//  Created by Jeff Jeong on 2020/06/01.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import SwiftUI

struct ContentView: View{
    
    init(){
        UITabBar.appearance().backgroundColor = .red
        UINavigationBar.appearance().backgroundColor = UIColor(named: "BackColor")
    }
    
    @State var selected = 0//시작tab
    
    var body: some View{
        TabView(selection: $selected){
            HomeView().tabItem({
                Image(systemName: "house")
                    .font(.title)
                Text ("\(Constants.TabBarText.tabBar0)")
            }).tag(0)
            
            RecipeSearchView().tabItem({
                Image(systemName: Constants.TabBarImageName.tabBar0)
                    .font(.title)
                Text ("\(Constants.TabBarText.tabBar1)")
            }).tag(1)
        }.accentColor(Color.red)
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
