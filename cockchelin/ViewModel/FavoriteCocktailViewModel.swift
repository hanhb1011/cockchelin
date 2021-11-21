//
//  FavoriteCocktailViewModel.swift
//  cockchelin
//
//  Created by 한효병 on 2021/11/02.
//

import Foundation

class FavoriteCocktailViewModel: ObservableObject {
    @Published var recipes: [Recipe]
    
    init(){
        self.recipes = RecipeModel.loadSavedRecipes()
    }
    
    func refresh() -> Void {
        self.recipes = RecipeModel.loadSavedRecipes()
    }
    
    func isFavorite(recipe: Recipe) -> Bool {
        return recipe.favoriteChecked
    }
    
    func hasNothingToShow() -> Bool {
        var isFound = false
        
        recipes.forEach { recipe in
            if (recipe.favoriteChecked) {
                isFound = true
            }
        }
        
        return (isFound == false)
    }
}
