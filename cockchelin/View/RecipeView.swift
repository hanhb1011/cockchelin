//
//  RecipeView.swift
//  SwiftUI Demo
//
//  Created by 한효병 on 2020/09/30.
//  Copyright © 2020 hb. All rights reserved.
//

import SwiftUI

struct RecipeView: View {
    
    var recipe: Recipe
    @ObservedObject var recipeViewModel: RecipeViewModel
    
    @State private var numberSelectorIndex = 0
    @State private var numbers: [Int] = [1, 2, 3, 4, 5]
    
    @State private var unitSelectorIndex = 0
    @State private var units: [LiquidUnitType] = [.ml, .oz]
    
    var body: some View {
        VStack {
            HStack {
                Text(recipeViewModel.recipe.name).bold()
                if (recipeViewModel.recipe.favoriteChecked) {
                    Image(systemName: "star.fill")
                        .onTapGesture {
                            self.recipeViewModel.checkFavorite()
                        }
                }
                else {
                    Image(systemName: "star")
                        .onTapGesture {
                            self.recipeViewModel.checkFavorite()
                        }
                }
            }
            Text("(\(recipe.alcoholDegree) %)")
            Text(recipeViewModel.recipe.lastTimeRecipeOpened.description).foregroundColor(.gray)
            
            Divider()
                .background(Color(.systemGray4))
                .padding(.leading)
            
            //TODO image
            
            HStack {
                Picker("Numbers", selection: $numberSelectorIndex) {
                    ForEach(0 ..< numbers.count) { index in
                        Text(String(self.numbers[index])).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .fixedSize()
                
                Picker("Units", selection: $unitSelectorIndex) {
                    ForEach(0 ..< units.count) { index in
                        Text(self.units[index].rawValue).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .fixedSize()
            }
            
            Text("재료").bold()
            ForEach(recipeViewModel.recipe.ingredients) { ingredient in
                HStack {
                    Text("\(ingredient.name)")
                    
                    Text(String(self.recipeViewModel.getLiquidVolume(ingredient: ingredient, liquidUnitType: self.units[unitSelectorIndex], numberOfServings: self.numbers[numberSelectorIndex])))
                    
                    if (ingredient.type == .oz || ingredient.type == .ml) {
                        Text(self.units[unitSelectorIndex].rawValue)
                    }
                    else {
                        Text(ingredient.type.rawValue)
                    }
                    
                }
                .padding()
                
                
            }
            
            Text("레시피").bold()
            Text(recipe.RecipeInformation).padding()
        }
        
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe //TODO change parameter type to UUID
        self.recipeViewModel = RecipeViewModel(recipe: recipe)
        
    }
}

#if DEBUG
let testRecipe = Recipe(name: "Recipe name", alcoholDegree: 25, ingredients: [Ingredient(name: "ingredient0", volume: 60, type: .ml), Ingredient(name: "ingredient1", volume: 1, type: .oz)], favoriteChecked: false, RecipeInformation: "recipe information", techniqueType: .build, lastTimeRecipeOpened: Date(), latitude: 0.0, longitude: 1.1, liquidColor: .blue, glassType: "glass type")
#endif

struct RecipeView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeView(recipe: testRecipe)
    }
}
