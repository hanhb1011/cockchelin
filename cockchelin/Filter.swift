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
    @Published var isMakeableSelected: Bool = false
    @Published var isFavoriteSelected: Bool = false
    @Published var colorsFilterItems: [LiquidColorType:Bool] = [
        .red : true, .blue : true, .pink : true, .yellow : true, .brown : true, .mixed : true,
        .none : true, .beige : true, .green : true, .black : true, .white: true, .orange : true
    ]
    
    @Published var selectedTechList: [TechniqueType:Bool] = [.build:true, .stir:true, .shake:true, .float: true, .blend:true]
    
    init() {
        
    }
    
    func isMakeableRecipe(recipe: Recipe) -> Bool {
        let ingredients = getIngredientsFromClassificationList()
        
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
        } else if (.orange == color || .yellow == color) {
            colorsFilterItems[.orange] = isChecked
            colorsFilterItems[.yellow] = isChecked
        } else if (.none == color || .white == color) {
            colorsFilterItems[.none] = isChecked
            colorsFilterItems[.white] = isChecked
        }
        else {
            colorsFilterItems[color] = isChecked
        }
        
        print(colorsFilterItems)
    }
}
