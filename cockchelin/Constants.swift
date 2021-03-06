//
//  Constants.swift
//  cocktail_201008
//
//  Created by Hyojin Choi on 2020/10/08.
//  Copyright © 2020 Hyojin Choi. All rights reserved.
//

import SwiftUI

extension Color{
    static let themeBackground = Color("BackgroundColor")
    static let themeSecondary = Color("SecondaryColor")
    static let themeForeground = Color("ForegroundColor")
}

struct Constants {
    struct TabBarImageName{
        static let tabBar0 = "heart.fill"
        static let tabBar1 = "heart.fill"
        static let tabBar2 = "book.fill"
        static let tabBar3 = "tmp3.fill"
        
    }
    
    struct TabBarText{
        static let tabBar0 = "home"
        static let tabBar1 = "recipe"
        static let tabBar2 = "bookmark"
        static let tabBar3 = "mypage"
        
    }
}

/*
struct Constants_Previews: PreviewProvider {
    static var previews: some View {
        Constants()
    }
}*/

struct Constants_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
