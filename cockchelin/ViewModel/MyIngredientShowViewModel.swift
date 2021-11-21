//
//  MyIngredientShowViewModel.swift
//  cockchelin
//
//  Created by 한효병 on 2021/11/02.
//

import Foundation

class MyIngredientShowViewModel: ObservableObject {
    
    @Published var recipes: [Recipe]
    @Published var ingredients: [String]
    
    init(){
        self.recipes = RecipeModel.loadSavedRecipes()
        self.ingredients = getIngredientsFromClassificationList()
        
    }
    
    func refresh() -> Void {
        self.recipes = RecipeModel.loadSavedRecipes()
        self.ingredients = getIngredientsFromClassificationList()
    }
    
    func isConditionallyMakeableRecipe(recipe: Recipe, diff: Int) -> Bool {
        var missCount = 0
        
        recipe.ingredients.forEach { ingredient in
            let ingredientInRecipe: String = ingredient.names[0]
            var found = false
            
            ingredients.forEach { givenIngredient in
                if (ingredientInRecipe == givenIngredient) {
                    found = true
                }
            }
            
            if (false == found) {
                missCount += 1
            }
        }
        
        if (missCount == diff) {
            return true
        }
        else {
            return false
        }
    }
    
    func isMakeableRecipe(recipe: Recipe) -> Bool {
        var isMakeable = true
        recipe.ingredients.forEach { ingredient in
            let ingredientInRecipe: String = ingredient.names[0]
            var found = false
            
            ingredients.forEach { givenIngredient in
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
    
    func hasNothingToShow() -> Bool {
        var isFound = false
        
        recipes.forEach { recipe in
            if (isMakeableRecipe(recipe: recipe)) {
                isFound = true
            }
        }
        
        return (isFound == false)
    }
}
