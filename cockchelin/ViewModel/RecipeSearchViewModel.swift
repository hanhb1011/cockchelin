//
//  RecipeSearchViewModel.swift
//  cockchelin
//
//  Created by 한효병 on 2020/10/31.
//

import Foundation



class RecipeSearchViewModel: ObservableObject {
    
    @Published var recipes: [Recipe]
    
    init(){
        self.recipes = RecipeModel.loadSavedRecipes()
    }
    
    func isMakeableRecipe(recipe: Recipe, givenIngredients: [String]) -> Bool {
        var isMakeable = true
        
        recipe.ingredients.forEach { ingredient in
            let ingredientInRecipe: String = ingredient.names[0]
            var found = false
            
            givenIngredients.forEach { givenIngredient in
                if (ingredientInRecipe == givenIngredient) {
                    found = true
                }
            }
            
            if (false == found) {
                isMakeable = false
            }
        }
        
        return isMakeable
    }
    
    
    
    
}
