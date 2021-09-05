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
        
        print("curretn date: \(currentDate)")
        print("last visited date: \(lastVisitedDate)")
        
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
    
    func getCocktailsForYou() -> [Recipe] {
        var recipesForYou: [Recipe] = []
        
        //find makeable recipes
        
        //if not, return random recipes
        
        
        return recipesForYou
    }
    
    func getRecentlyViewedCocktails(maxCount: Int) -> [Recipe] {
        let recentlyViewedCocktails: [Recipe] = recipes
            .filter {$0.lastTimeRecipeOpened != nil}
            .sorted { $0.lastTimeRecipeOpened! > $1.lastTimeRecipeOpened!}
            
        let adjustedMax = recentlyViewedCocktails.count < maxCount ? recentlyViewedCocktails.count : maxCount
        
        return Array(recentlyViewedCocktails[0..<adjustedMax])
    }
    
}
