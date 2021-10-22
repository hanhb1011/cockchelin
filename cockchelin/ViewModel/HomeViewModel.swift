//
//  HomeViewModel.swift
//  cockchelin
//
//  Created by 한효병 on 2021/09/04.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe]
    @Published var classificationList: [Classification]
    
    init(){
        self.recipes = RecipeModel.loadSavedRecipes()
        self.classificationList = loadClassifications()!
    }
    
    func refresh() {
        self.recipes = RecipeModel.loadSavedRecipes()
        self.classificationList = loadClassifications()!
    }
    
    func getLastVisitedDateFromUserDefaults() -> Date? {
        let defaults = UserDefaults.standard
        if let lastVisitedDate = defaults.object(forKey: "LastVisitedDate") as? Data {
            let decoder = JSONDecoder()
            if let lastVisitedDate = try? decoder.decode(Date.self, from: lastVisitedDate) {
                return lastVisitedDate
            }
        }
        
        return nil
    }
    
    func getTodaysRecipeFromUserDefaults() -> Recipe? {
        let defaults = UserDefaults.standard
        if let savedRecipe = defaults.object(forKey: "TodaysRecipe") as? Data {
            let decoder = JSONDecoder()
            if let savedRecipe = try? decoder.decode(Recipe.self, from: savedRecipe) {
                return savedRecipe
            }
        }
        
        return nil
    }
    
    func updateTodaysRecipe(recipe: Recipe) -> Void {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipe) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "TodaysRecipe")
        }
        
        //update last visited date
        let currentDate = Date()
        if let encoded = try? encoder.encode(currentDate) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "LastVisitedDate")
        }
    }
    
    func getTodaysCocktail() -> Recipe {
        var recipe: Recipe? = nil
        var isUpdateNeeded: Bool = false
        
        //get today's date
        let currentDate = Date()
        
        //get last visited date
        let lastVisitedDate = getLastVisitedDateFromUserDefaults()
        
        if (lastVisitedDate == nil) {
            isUpdateNeeded = true
        }
        else if (Calendar.current.compare(lastVisitedDate!, to: currentDate, toGranularity: .day).rawValue != 0){
            isUpdateNeeded = true
        }
        else {
            recipe = getTodaysRecipeFromUserDefaults()
            if (recipe == nil) {
                isUpdateNeeded = true
            }
        }
        
        if (isUpdateNeeded == true) {
            recipe = recipes.randomElement()
            updateTodaysRecipe(recipe: recipe!)
        }
        
        return recipe!
    }
    
    func isMakeableRecipe(recipe: Recipe, ingredients: [String], minDiff: Int) -> Bool {
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
         
        if (missCount <= minDiff) {
            
            return true
        }
        else {
            return false
        }
    }
    
    func getMakebaleRecipes(recipeCount: Int) -> [Recipe] {
        var makeableRecipes: [Recipe] = []
        let ingredients: [String] = getIngredientsFromClassificationList()
        makeableRecipes = recipes.filter { isMakeableRecipe(recipe: $0, ingredients: ingredients, minDiff: 1) }
        
        makeableRecipes.shuffle()
        
        if (recipeCount < makeableRecipes.count) {
            makeableRecipes.removeSubrange(recipeCount..<makeableRecipes.count)
        }
        
        return makeableRecipes
    }
    
    func getFavoriteRecipes(recipeCount: Int) -> [Recipe] {
        var favoriteRecipes: [Recipe] = recipes.filter { $0.favoriteChecked == true }
        
        favoriteRecipes.shuffle()
        
        if (recipeCount < favoriteRecipes.count) {
            favoriteRecipes.removeSubrange(recipeCount..<favoriteRecipes.count)
        }
        
        return favoriteRecipes
    }
    
    func combine(_ left: [Recipe], _ right: [Recipe]) -> [Recipe] {
        var candidates: [Recipe] = left + right
        var duplicateIndice: [Int] = []
        
        for i in (0..<candidates.count) {
            var isDuplicated = false
            for j in (i+1..<candidates.count) {
                if (candidates[i].id == candidates[j].id) {
                    isDuplicated = true
                }
            }
            
            if (isDuplicated == true) {
                duplicateIndice.append(i)
            }
        }
        
        duplicateIndice.sorted().reversed().forEach { i in
            candidates.remove(at: i)
        }
        
        return candidates
    }

    func getCocktailsForYou(maxCount: Int) -> [Recipe] {
        /*
            1. select makeable recipes.
            2. select recipes that were in the bookmark list.
            3. select random recipes.
            4. shuffle and return.
         */
        let makeableCocktails = getMakebaleRecipes(recipeCount: 7)
        let favoriteCocktails = getFavoriteRecipes(recipeCount: 3)

        var candidates: [Recipe] = combine(makeableCocktails, favoriteCocktails)
        var recipeCount = candidates.count
        
        while (recipeCount < maxCount) {
            let randomElement = recipes.randomElement()!
            var isDuplicated = false
            candidates.forEach { recipe in
                if (recipe.names[0] == randomElement.names[0]) {
                    isDuplicated = true
                }
            }
            if (isDuplicated == false) {
                candidates.append(randomElement)
                recipeCount += 1
            }
        }
        
        return candidates
    }
    
    func getRecentlyViewedCocktails(maxCount: Int) -> [Recipe] {
        let recentlyViewedCocktails: [Recipe] = recipes
            .filter {$0.lastTimeRecipeOpened != nil}
            .sorted { $0.lastTimeRecipeOpened! > $1.lastTimeRecipeOpened!}
        
        let adjustedMax = recentlyViewedCocktails.count < maxCount ? recentlyViewedCocktails.count : maxCount
        
        return Array(recentlyViewedCocktails[0..<adjustedMax])
    }
    
}
