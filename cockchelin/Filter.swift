//
//  Filter.swift
//  cockchelin
//
//  Created by 한효병 on 2021/01/03.
//

import Foundation


class Filter: ObservableObject {
    @Published var minDegree: Double = 0.0
    @Published var maxDegree: Double = 50.0
    
    @Published var isEnabled: Bool = false
    @Published var ingredients: [String] = []
    @Published var colorsFilterItems: [LiquidColorType:Bool] = [
        .red : false, .blue : false, .pink : false, .yellow : false, .brown : false, .mixed : false,
        .none : false, .beige : false, .green : false, .black : false
    ]
    
    init() {
        
    }
    
    func printIngredients() {
        print(ingredients)
    }
    
    func updateIngredients(givenIngredients: [String]) {
        
        self.ingredients = givenIngredients
        
        print(ingredients)
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
    
    func isSelectedColor(color: LiquidColorType) -> Bool {
        return colorsFilterItems[color]!
    }
    
    func updateSelectedColor(color: LiquidColorType, isChecked: Bool) -> Void {
        if (.brown == color || .beige == color) {
            colorsFilterItems[.brown] = isChecked
            colorsFilterItems[.beige] = isChecked
        } else if (.red == color || .pink == color) {
            colorsFilterItems[.red] = isChecked
            colorsFilterItems[.pink] = isChecked
        }
        else {
            colorsFilterItems[color] = isChecked
        }

        print(colorsFilterItems)
    }
}
