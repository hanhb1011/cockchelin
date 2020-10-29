//
//  RecipeListViewModel.swift
//  SwiftUI Demo
//
//  Created by 한효병 on 2020/10/05.
//  Copyright © 2020 hb. All rights reserved.
//

import Foundation

class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe]
    
    func test() {
        let randomIndex = Range(1...recipes.count - 1).randomElement()!
        
        self.recipes[randomIndex].favoriteChecked = !self.recipes[randomIndex].favoriteChecked
        self.recipes[randomIndex].lastTimeRecipeOpened = Date()
        
        RecipeModel.updateRecipe(recipe: self.recipes[randomIndex])
    }
    
    init(){
        recipes = RecipeModel.loadSavedRecipes()
    }

}
