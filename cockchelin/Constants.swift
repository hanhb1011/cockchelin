//
//  Constants.swift
//  cocktail_201008
//
//  Created by Hyojin Choi on 2020/10/08.
//  Copyright © 2020 Hyojin Choi. All rights reserved.
//

import SwiftUI

extension Color{
    static let themeBackground = Color(red: 247/255, green: 247/255, blue: 251/255, opacity: 100)
    static let themeSecondary = Color("SecondaryColor")
    static let themeForeground = Color("ForegroundColor")
    static let selectedButtonColor = Color(red: 255/255, green: 100/255, blue: 168/255, opacity: 100)
    
    static let myRed = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    static let myBlue = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    static let myYellow = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    static let myBrown = #colorLiteral(red: 0.8643242717, green: 0.5780742168, blue: 0.1301657856, alpha: 1)
    static let myMixed = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    static let myTransparent = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let myGreen = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    static let myBlack = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
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
