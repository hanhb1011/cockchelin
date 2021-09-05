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
        print(recipe.lastTimeRecipeOpened)
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
    
    func getTechniqueKorean(type: TechniqueType) -> String {
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
            res.append(getTechniqueKorean(type: type))
            
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
    
    func getRecipeProcessString(recipeProcess: RecipeProcess) -> String {
        var res: String = ""
        
        if (recipeProcess.ingredientIndex != -1)
        {
            res.append(recipe.ingredients[recipeProcess.ingredientIndex].names[0])
            res.append(" 을(를)") /* TODO: differentiate 을, 를 */
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
