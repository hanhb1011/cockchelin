//
//  IngredientManager.swift
//  RecipeGenerator
//
//  Created by 한효병 on 2021/03/14.
//

import Foundation

func getIngredientsFromJSONFile() -> [String] {

    guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }
    let fileLocation = documentDirectoryUrl.appendingPathComponent("Ingredients.json")
    
    do {
        let data = try Data(contentsOf: fileLocation)
        let jsonDecoder = JSONDecoder()
        let dataFromJson = try jsonDecoder.decode([String].self, from: data)
        return dataFromJson
    } catch {
        print(error)
    }
    
    return []
}

func saveIngredientsToJSONFile(ingredients: [String]) {
    
    let jsonEncoder = JSONEncoder()
    let jsonString: String!
    do {
        let jsonData = try jsonEncoder.encode(ingredients)
        jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
    } catch {
        print("file save error")
        return
    }
    
    //print(jsonString)

    // Create data to be saved
    let data = jsonString.data(using: .utf8)!

    guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let fileUrl = documentDirectoryUrl.appendingPathComponent("Ingredients.json")
    
    do {
        try data.write(to: fileUrl, options: [])
        print("saved: \(documentDirectoryUrl.absoluteURL)")
    } catch {
        print(error)
    }
}

func getIngredients() -> [String] {
    var ingredients: [String] = []
    guard let recipes = RecipeModel.getSavedRecipesFromJSONFile() else {
        return ingredients
    }
    
    recipes.forEach { recipe in
        recipe.ingredients.forEach { item in
            let ingredient: String = item.names[0]
            
            if false == ingredients.contains(ingredient) {
                ingredients.append(ingredient)
            }
        }
    }
    
    return ingredients
}

func printIngredients() {
    let ingredients = getIngredients()
    print(ingredients)
    
    saveIngredientsToJSONFile(ingredients: ingredients)
}

