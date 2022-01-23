//
//  RecipeRepository.swift
//  SwiftUI Demo
//
//  Created by 한효병 on 2020/09/30.
//  Copyright © 2020 hb. All rights reserved.
//

import Foundation
import SwiftUI

class RecipeModel {
    
    static func loadSavedRecipes() -> [Recipe] {
        
        let recipesFromUserDefaults = getSavedRecipesFromUserDefaults()
        let recipesFromJSONFile = getSavedRecipesFromJSONFile()
        
        if (recipesFromUserDefaults == nil) {
            return recipesFromJSONFile!
        }
        
        if (recipesFromUserDefaults!.count < recipesFromJSONFile!.count) {
            updateAllRecipesToUserDefaults(recipes: recipesFromJSONFile!) //todo: delete this code before release...
            return recipesFromJSONFile!
        }
        
        return recipesFromUserDefaults!
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
            if (recipe.id == currentRecipe.id) {
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
    
    static func updateAllRecipesToUserDefaults(recipes: [Recipe]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipes) {
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
    
    static func getRandomCocktailImageName() -> String {
        let randomCocktailImages: [String] = ["temp", "temp2", "todayCocktail"]
        
        return randomCocktailImages.randomElement()!
    }
    
    static func getNameOfGlass(glassType: GlassType) -> String {
        var adjsutedGlassType: String = glassType.rawValue
        
        /*
         stemmedLiqueurGlass -> sherryGlass
         cocktailGlass
         oldFashonedGlass
         highballGlass
         footedPilsnerGlass
         sourGlass
         collinsGlass
         sherryGlass
         champagneGlass
         whiteWineGlass
         */
        
        switch (glassType) {
        case .sourGlass:
            adjsutedGlassType = "whiteWineGlass"
        case .stemmedLiqueurGlass:
            adjsutedGlassType = "shotGlass"
        case .cocktailGlass:
            break
        case .oldFashonedGlass:
            break
        case .highballGlass:
            break
        case .footedPilsnerGlass:
            adjsutedGlassType = "highballGlass"
        case .collinsGlass:
            adjsutedGlassType = "highballGlass"
        case .sherryGlass:
            adjsutedGlassType = "shotGlass"
            break
        case .champagneGlass:
            break
        case .whiteWineGlass:
            break
        }
        
        return adjsutedGlassType
    }
    
    static func getImageNameOfMixedColor(recipe: Recipe) -> String {
        
        if (recipe.names[0] == "커비 블루") {
            return "Cubby Blue"
        }
        else if (recipe.names[0] == "B-52") {
            return "B-52"
        }
        
        return recipe.names[1]
    }
    
    static func isValidName(imageName: String) -> Bool {
        return true
    }
    
    static func getCocktailImageName(recipe: Recipe) -> String {
        let glass: String = getNameOfGlass(glassType: recipe.glassType)
        let liquidColor: String = recipe.liquidColor.rawValue
        var imageName: String
        
        if (.mixed == recipe.liquidColor) {
            imageName = getImageNameOfMixedColor(recipe: recipe)
        } else {
            imageName = glass + "_" + liquidColor
        }
        
        //check
        if (true == isValidName(imageName: imageName)) {
            return imageName
        } else {
            return glass + "_none"
        }
        
    }
}
