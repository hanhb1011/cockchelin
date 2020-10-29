//
//  RecipeViewModel.swift
//  SwiftUI Demo
//
//  Created by 한효병 on 2020/09/30.
//  Copyright © 2020 hb. All rights reserved.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipe: Recipe
    
    init(recipe: Recipe){
        self.recipe = recipe
        updateCurrentTimestamp()
    }
    
    func checkFavorite() {
        self.recipe.favoriteChecked = !self.recipe.favoriteChecked
        RecipeModel.updateRecipe(recipe: recipe)
    }
    
    func updateCurrentTimestamp() {
        recipe.lastTimeRecipeOpened = Date()
        print(recipe.lastTimeRecipeOpened.description)
        RecipeModel.updateRecipe(recipe: recipe)
    }
    
    func getLiquidVolume(ingredient: Ingredient, liquidUnitType: LiquidUnitType, numberOfServings: Int) -> Double {
        var liquidVolume: Double = 0.0
        
        var unitRatio: Double
        
        if (ingredient.type == .ml && liquidUnitType == .oz) {
            unitRatio = (1.0/30.0)
        }
        else if (ingredient.type == .oz && liquidUnitType == .ml) {
            unitRatio = 30.0
        }
        else {
            unitRatio = 1.0
        }
        
        liquidVolume = ingredient.volume * unitRatio * Double(numberOfServings)
        
        return liquidVolume
    }
}
