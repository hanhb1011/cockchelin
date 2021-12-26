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
        .none : true, .beige : true, .green : true, .black : true, .white: true, .orange : true, .lightYellow : true
    ]
    
    @Published var selectedTechList: [TechniqueType:Bool] = [.build:true, .stir:true, .shake:true, .float: true, .blend:true]
    
    @Published var selectedBaseList: [IngredientSearchItem] = [
        IngredientSearchItem(ingredientName: "진", selected: true),
        IngredientSearchItem(ingredientName: "럼", selected: true),
        IngredientSearchItem(ingredientName: "보드카", selected: true),
        IngredientSearchItem(ingredientName: "위스키", selected: true),
        IngredientSearchItem(ingredientName: "브랜디", selected: true),
        IngredientSearchItem(ingredientName: "데킬라", selected: true),
        IngredientSearchItem(ingredientName: "와인", selected: true),
        IngredientSearchItem(ingredientName: "샴페인", selected: true),
        
    ]
    
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
            colorsFilterItems[.lightYellow] = isChecked
        }
        else {
            colorsFilterItems[color] = isChecked
        }
    }
    
    func toggleBaseItem(id: UUID) -> Void {
        selectedBaseList = selectedBaseList.map {
            if ($0.id != id) {
                return $0
            }
            
            var modifiedItem = $0
            modifiedItem.selected.toggle()
            return modifiedItem
        }
        
    }
    
    func isSelectedBaseContained(ingredients: [Ingredient]) -> Bool {
        var ret = false
        
        ingredients.forEach { ingredient in
            ingredient.names.forEach { name in
                selectedBaseList.forEach { item in
                    if (item.selected) {
                        if (name.contains(item.ingredientName)) {
                            ret = true
                        }
                    }
                }
            }
        }
        
        
        return ret
    }
    
    func isSelectedTech(techtypes: [TechniqueType]) -> Bool {
        var ret = false
        
        techtypes.forEach { tech in
            if (selectedTechList[tech] == true) {
                ret = true
            }
        }
        
        return ret
    }
}
