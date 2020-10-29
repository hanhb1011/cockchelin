//
//  RecipeRepository.swift
//  SwiftUI Demo
//
//  Created by 한효병 on 2020/09/30.
//  Copyright © 2020 hb. All rights reserved.
//

import Foundation

class RecipeModel {
    
    static func loadSavedRecipes() -> [Recipe] {
        
        if let recipesFromUserDefaults = getSavedRecipesFromUserDefaults() {
            return recipesFromUserDefaults
        }
        
        return getSavedRecipesFromJSONFile()!
    }
    
    static func getSavedRecipesFromJSONFile() -> [Recipe]? {
        
        if let fileLocation = Bundle.main.url(forResource: "RecipeData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Recipe].self, from: data)
                return dataFromJson
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
    static func getSavedRecipesFromUserDefaults() -> [Recipe]? {
        let defaults = UserDefaults.standard
        if let savedRecipes = defaults.object(forKey: "SavedRecipes") as? Data {
            let decoder = JSONDecoder()
            if let savedRecipes = try? decoder.decode([Recipe].self, from: savedRecipes) {
                return savedRecipes
            }
        }
        
        return nil
    }
    
    static func updateRecipe(recipe: Recipe) {
        
        let savedRecipes: [Recipe] = loadSavedRecipes()
        
        let changedRecipes = savedRecipes.map { (currentRecipe) -> Recipe in
            if (recipe.name == currentRecipe.name) {
                var modifiedRecipe = currentRecipe
                modifiedRecipe = recipe
                return modifiedRecipe
            }
            else {
                return currentRecipe
            }
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(changedRecipes) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedRecipes")
        }
        
    }
        
    static func findRecipeById(id: UUID) -> Recipe {
        let savedRecipes: [Recipe] = loadSavedRecipes()
        var foundedRecipe: Recipe!
        
        savedRecipes.forEach { recipe in
            if (recipe.id == id) {
                foundedRecipe = recipe
            }
        }
        
        return foundedRecipe
    }
}
