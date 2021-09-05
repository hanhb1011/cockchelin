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

func loadClassifications() -> [Classification]? {
    
    if let classificationsFromUserDefaults = getClassificationsFromUserDefaults() {
        return classificationsFromUserDefaults
    }
    
    if let classificationsFromJSONFile = getClassificationsFromJSONFile() {
        return classificationsFromJSONFile
    }
    
    return nil
}

func getIngredientsFromClassificationList() -> [String] {
    var ingredients: [String] = []
    let classificationList = loadClassifications()!
    classificationList.forEach { classification in
        classification.ingredientSearchItems.forEach { ingredientSearchItem in
            if (ingredientSearchItem.selected) {
                ingredients.append(ingredientSearchItem.ingredientName)
            }
        }
    }
    
    return ingredients
}

func getClassificationsFromJSONFile() -> [Classification]? {
    
    if let fileLocation = Bundle.main.url(forResource: "Classifications", withExtension: "json") {
        do {
            let data = try Data(contentsOf: fileLocation)
            let jsonDecoder = JSONDecoder()
            let dataFromJson = try jsonDecoder.decode([Classification].self, from: data)
            return dataFromJson
        } catch {
            print(error)
        }
    }
    
    return nil
}

func getClassificationsFromUserDefaults() -> [Classification]? {
    let defaults = UserDefaults.standard
    if let savedClassifications = defaults.object(forKey: "SavedClassifications") as? Data {
        let decoder = JSONDecoder()
        if let savedClassifications = try? decoder.decode([Classification].self, from: savedClassifications) {
            return savedClassifications
        }
    }
    
    return nil
}

func saveClassificationsToUserDefaults(classifications: [Classification]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(classifications) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "SavedClassifications")
    }
    
}

