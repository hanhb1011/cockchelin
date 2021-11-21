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
    }
    
    func checkFavorite() {
        self.recipe.favoriteChecked = !self.recipe.favoriteChecked
        RecipeModel.updateRecipe(recipe: recipe)
    }
    
    func updateCurrentTimestamp() {
        recipe.lastTimeRecipeOpened = Date()
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
        
        liquidVolume = round(ingredient.volume * unitRatio * Double(numberOfServings) * 100) / 100
        
        return liquidVolume
    }
    
    static func getTechniqueKorean(type: TechniqueType) -> String {
        switch type {
        case .blend:
            return "블렌드"
        case .build:
            return "빌드"
        case .float:
            return "플로트"
        case .stir:
            return "스터"
        case .shake:
            return "쉐이크"
        }
    }
    
    func getTechniqueTypes() -> String {
        var res: String = ""
        var count = 0
        recipe.techniqueTypes.forEach { type in
            res.append(RecipeViewModel.getTechniqueKorean(type: type))
            
            if (count < recipe.techniqueTypes.count - 1)
            {
                res.append(", ")
            }
            count += 1
        }
        
        return res
    }
    
    func getBehaviorKorean(type: BehaviorType) -> String {
        switch type {
        case .addIceCubes:
            return "얼음을 채운다."
        case .build:
            return "빌드한다."
        case .stir:
            return "젓는다."
        case .shake:
            return "얼음과 함께 쉐이크한다."
        case .float:
            return "플로팅한다."
        case .blend:
            return "블렌딩한다."
        case .pour:
            return "넣는다."
        case .crush:
            return "으깬다."
        case .fillup:
            return "채운다."
        }
        
    }
    
    func postPositionText(_ name: String) -> String {
        guard let lastText = name.last else { return name }

        let unicodeVal = UnicodeScalar(String(lastText))?.value

        guard let value = unicodeVal else { return name }

        if (value < 0xAC00 || value > 0xD7A3) { return name + " " }

        let last = (value - 0xAC00) % 28

        let str = last > 0 ? "을 " : "를 "

        return name + str
    }
    
    static func updateSelectedUnitIndex(selectedUnitIndex: Int) -> Void {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(selectedUnitIndex) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SelectedUnitIndex")
        }
    }
    
    static func getSelectedUnitIndex() -> Int {
        let defaults = UserDefaults.standard
        
        if let selectedUnitIndex = defaults.object(forKey: "SelectedUnitIndex") as? Data {
            let decoder = JSONDecoder()
            if let selectedUnitIndex = try? decoder.decode(Int.self, from: selectedUnitIndex) {
                return selectedUnitIndex
            }
        }
        
        //if nil, initialize to zero.
        RecipeViewModel.updateSelectedUnitIndex(selectedUnitIndex: 0)
        
        return 0
    }
    
    func isPourIntoShaker(recipeProcess: RecipeProcess) -> Bool {
        var ret = false
        var found = false
        
        if (recipeProcess.behavior != .pour) {
            return false
        }
        
        self.recipe.RecipeInformation.forEach { process in
            
            if (process.id == recipeProcess.id) {
                found = true
            }
            
            if (found == true && process.behavior == .shake) {
                ret = true
            }
        }
        
        return ret
    }
    
    func getGarnishString() -> String {
        return recipe.garnish!
    }
    
    func getRecipeProcessString(recipeProcess: RecipeProcess) -> String {
        var res: String = ""
        
        if (recipeProcess.ingredientIndex != -1)
        {
            res.append(postPositionText(recipe.ingredients[recipeProcess.ingredientIndex].names[0]))
        }
        
        if (isPourIntoShaker(recipeProcess: recipeProcess) == true)
        {
            res.append("쉐이커에 ")
        }
                
        res.append(getBehaviorKorean(type: recipeProcess.behavior))
        
        return res
    }
    
    func getIndexImage(index: Int) -> String {
        var res: String = ""
        
        if (index < 10) {
            res.append("0")
            res.append(String(index))
        }
        else
        {
            res = String(index)
        }
        
        res.append(".square")
        return res
    }
}
